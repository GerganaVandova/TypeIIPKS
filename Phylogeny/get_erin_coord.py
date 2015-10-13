#!/usr/bin/env python

# The script takes referense set file which is a tab-delimited file with
# genbank id and cluster description
# and a nonredundant file which is a fasta file with genbank id and domain
# coordinates and domain sequence

# To run script:

# To generate gbid_coordinates <tab> description output:
# comment line #79 and comment out line #81
# ./get_erin_coord.py > erin_t2[domain]_gbids_descriptions_coord.78.txt

# To generate >gbid_description fasta file with reference sequences:
# comment out line #79 and comment line #81
# ./get_erin_coord.py > [domain].[number of seqs].withdescr.fasta

import os


def main():

    refsetfile = "erin_refset_gbids_descriptions.78.txt"
    # nonredundantfile = "../KSCLF_tandem/t2clf.selectKnown12.hmm.hmmsearch.parsed.161.withTandemKS.cdhit.88.withrefseqs"
    # write in erin_t2clf_gbids_descriptions_coord.78.txt

    # nonredundantfile = "../KSCLF_tandem/t2ks.selectKnown12.hmm.hmmsearch.parsed.323.withTandemCLF.cdhit.93.withrefseqs"
    # write in erin_t2ks_gbids_descriptions_coord.78.txt


    # Updated on Aug 14, 2015
    nonredundantfile = "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs"
    # write in erin_t2acp_gbids_descriptions_coord.txt

    # nonredundantfile = "t2kr.selectKnown17.hmm.hmmsearch.parsed.29.withTandemKSCLF.cdhit.99.withrefids"
    # write in erin_t2kr_gbids_descriptions_coord.txt

    # nonredundantfile = "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.cdhit.99.withrefids"
    # write in erin_t2at_gbids_descriptions_coord.txt

    # nonredundantfile = "t2cyclaseSRPBCC.selectKnown17.hmm.hmmsearch.parsed.20.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids"
    # write in erin_t2cyclaseSRPBCC_gbids_descriptions_coord.78.txt

    # nonredundantfile = "t2ksiii.selectKnown10.hmm.hmmsearch.parsed.62.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids"
    # write in erin_t2ksiii_gbids_descriptions_coord.txt

    nonredundant_ids = []
    nr_id_to_seq = {}

    from Bio import SeqIO
    handle = open(nonredundantfile, "r")
    for record in SeqIO.parse(handle, "fasta"):
        # print record.seq
        # print record.id
        nr_id_to_seq[record.id] = record.seq
        nonredundant_ids.append(record.id)
    handle.close()

    # print nr_id_to_seq

    refset = set()
    missing_ref = set()
    refid_to_descr = {}

    f1 = open(refsetfile)
    for line in f1.readlines():
        line = line.strip()
        ref_id, descr = line.split("\t")
        refset.add(ref_id)
        missing_ref.add(ref_id)
        refid_to_descr[ref_id] = descr
    # print refset

    # print nr_id_to_seq.keys()


    for nr_id in nonredundant_ids:
        # print nr_id
        nr_id_no_coord, coord = nr_id.rsplit("_", 1)
        if nr_id_no_coord in refset:
            print ">" + nr_id_no_coord + "_" + refid_to_descr[nr_id_no_coord], "\n", nr_id_to_seq[nr_id]#to extract sequences for tanglegram, delete if using to get coord only!!!!!!!!!
            # print nr_id_no_coord, "\t", refid_to_descr[nr_id_no_coord], "\t", coord
            # print nr_id_no_coord + "_" + coord, "\t", refid_to_descr[nr_id_no_coord]# to generate gbid_coord <tab> descriptions file
            if nr_id_no_coord in missing_ref:
                missing_ref.remove(nr_id_no_coord)
    # print missing_ref


if __name__ == "__main__":
    main()
