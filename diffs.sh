#!/usr/bin/env bash

#@test{"stdout":20, "stderr": 20}
ls -1 src/Hello.java

ant -f instructor-build.xml clean

#@test{"return":10}
ant -f instructor-build.xml compile

#@test{"return":10}
ant -f instructor-build.xml jar

#@test{"stdout":20, "stderr": 20}
ls -1 build/My-Project.jar 

#@test{"stdout":20, "stderr": 20}
java -cp build/My-Project.jar Hello







