#!/bin/sh

ant -f instructor-build.xml clean
ant -f instructor-build.xml compile
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

outfile=unittest-results.json
/bin/rm -vf $outfile
echo "About to generate $outfile in" `pwd` "..."
java -cp ${classpath}:build/My-Project.jar RunTests > $outfile









