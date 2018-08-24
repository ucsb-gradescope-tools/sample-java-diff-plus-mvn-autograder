#!/bin/sh


MAIN_JAR=target/m18_labxx-1.0-SNAPSHOT.jar
TEST_JAR=target/m18_labxx-1.0-SNAPSHOT-tests.jar
RUNTESTS=edu.ucsb.cs56.pconrad.m18_labxx.RunTests

### SHOULD NOT NEED TO EDIT BELOW THIS LINE


function die { exit 1; }

function mvn_do {

    commands=($*)
    echo "*** About to do mvn $commands ***"
    mvn -f instructor-pom.xml $commands 1> compile.out 2> compile.err
    result=$?
    echo "*** status code from mvn $commands is $result ***"

    if [ "$result" -ne 0 ];
    then
	if [ "$1" == "compile" ];
	then
	   echo "*** Unable to compile the submission ***"
	   ../make_compiler_error_message_json.py > $outfile
	   die
	else
	   echo "*** Bad return code from mvn $commands ***" > unittests.err
	   ../make_unittests_error_message_json.py > $outfile
	   die
	fi
    fi
}


if [ ! -f instructor-pom.xml ];
then
    echo "*** Could not find instructor-pom.xml" > unittests.err
    ../make_unittests_error_message_json.py > $outfile
    die
fi

outfile=unittest-results.json
/bin/rm -vf $outfile
echo "About to generate $outfile in" `pwd` "..."

mvn_do clean
mvn_do compile
mvn -f instructor-pom.xml test  # This puts output in the instructor log for reference
mvn_do package
mvn_do jar:test-jar

classpath=""

for jar in ../EXECUTION-FILES/lib/*.jar ; do
    if [ -z "$classpath" ] ;
    then
	classpath=$jar
    else
	classpath="${classpath}:${jar}"
    fi
done

echo "classpath is $classpath"

if [ ! -f "${TEST_JAR}" ];
then
    echo "Could not locate expected jar file to run unit tests: ${TEST_JAR}" > unittests.err
    ../make_unittests_error_message_json.py > $outfile
fi    

if [ ! -f "${MAIN_JAR}" ];
then
    echo "Could not locate expected jar file for classes: ${MAIN_JAR}" > unittests.err
    ../make_unittests_error_message_json.py > $outfile
fi    


java_command="java -cp ${classpath}:${TEST_JAR}:${MAIN_JAR} ${RUNTESTS}"
echo "About to run java command: $java_command"
${java_command} 1> $outfile 2>unittests.err
if [ ! $? -eq 0 ];
then
    ../make_unittests_error_message_json.py > $outfile
fi    






