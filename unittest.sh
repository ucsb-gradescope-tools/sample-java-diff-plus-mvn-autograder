#!/bin/sh

expected_jar_for_tests=build/My-Project.jar

### SHOULD NOT NEED TO EDIT BELOW THIS LINE

outfile=unittest-results.json
/bin/rm -vf $outfile
echo "About to generate $outfile in" `pwd` "..."

ant -f instructor-build.xml clean

ant -f instructor-build.xml compile 1> compile.out 2> compile.err
compiler_status_code=$?
echo "**** status code from compile step is $compiler_status_code ****"


if [ "$compiler_status_code" -ne 0 ];
then
    echo "*** Unable to compile the submission ***"
    ../make_compiler_error_message_json.py > $outfile
else

    ant -f instructor-build.xml jar
    ant -f instructor-build.xml test

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

    if [ -f "${expected_jar_for_tests}" ];
    then
	echo "About to run java command"
	java -cp ${classpath}:build/My-Project.jar RunTests 1> $outfile 2>unittests.err
	if [ ! $? -eq 0 ];
	then
	    ../make_unittests_error_message_json.py > $outfile
	fi    
    else
	echo "Could not locate expected jar file to run unit tests: ${expected_jar_for_tests}" > unittests.err
	../make_unittests_error_message_json.py > $outfile
    fi    
 fi







