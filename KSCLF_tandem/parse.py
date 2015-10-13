#!/usr/bin/env python
import os
import sys

f1 = open(sys.argv[1])
for line in f1.readlines():
    if line.startswith(">"):
    	line = line.strip()
    	id, coord = line.rsplit("_", 1)
    	#print id, "\t", coord
    	print id
