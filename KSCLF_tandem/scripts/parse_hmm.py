#!/usr/bin/env python
import os
import sys

f1 = open(sys.argv[1])
for line in f1.readlines():
    line = line.strip()
    ksclfid, kscoord, ksseq, clfcoord, clfseq = line.split("\t")
    kscoord1, kscoord2 = kscoord.split('-')
    print ksclfid + ".1__" + kscoord1 + "_" + kscoord2 + "_Streptomyces_sp._AA0539_contig00003__whole_genome_shotgun_sequence_2_-1_281910_1e-162", "\t", "2", "\t", "3", "\t", "4", "\t", "5", "\t", "6", "\t", "7", "\t", "8", "\t", ksseq
