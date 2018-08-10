#!/usr/bin/env bash

#@test{"stdout":20, "stderr": 20}
ls -1 Hello.java

#@test{"stdout":5, "stderr": 15}
javac Hello.java

#@test{"stdout":20, "stderr":20}
java Hello

