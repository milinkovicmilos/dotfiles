#!/usr/bin/env python

import sys, json

def getActive(json):
    for x in json:
        if (x["focused"]):
            return x["name"]

json = json.loads(sys.stdin.read())
print(getActive(json))
