#!/bin/env python

import os, csv, json

csv_reader = csv.reader(os.sys.stdin)

for l in csv_reader:
    print(json.dumps(l))
