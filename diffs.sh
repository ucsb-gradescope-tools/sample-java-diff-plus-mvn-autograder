#!/usr/bin/env bash

#@test{"stdout":1, "stderr": 1}
ls -1 src/main/java/edu/ucsb/cs56/pconrad/m18_labxx/Hello.java

#@test{"stdout":1, "stderr": 1}
ls -1 src/main/java/edu/ucsb/cs56/pconrad/m18_labxx/Assignment.java

#@test{"stdout":1, "stderr": 1}
ls -1 pom.xml

mvn -f instructor-pom.xml clean

#@test{"return":1}
mvn -f instructor-pom.xml compile

#@test{"return":1,"timeout":10}
mvn -f instructor-pom.xml package

#@test{"stdout":1, "stderr": 1, "return":1}
ls -1 target/m18_labxx-1.0-SNAPSHOT.jar

#@test{"stdout":1, "stderr": 1}
java -cp target/m18_labxx-1.0-SNAPSHOT.jar edu.ucsb.cs56.pconrad.m18_labxx.Hello







