#!/usr/bin/env python3

import json

with open('unittests.err','r') as infile:
    unittest_output = infile.read()

the_test = {"name": "UNIT TESTING ERROR", "max_score": 1, "score": 0  , "output": unittest_output }
json_output_as_dict = { "tests" : [ the_test ] }

print(json.dumps(json_output_as_dict))










