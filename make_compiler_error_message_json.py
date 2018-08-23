#!/usr/bin/env python3

import json

with open('compile.out','r') as infile:
    compiler_output = infile.read()

the_test = {"name": "COMPILER ERROR", "max_score": 1, "score": 0  , "output": compiler_output}
json_output_as_dict = { "tests" : [ the_test ] }

print(json.dumps(json_output_as_dict))










