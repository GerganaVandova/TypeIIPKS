#!/usr/bin/env python
import os
import argparse

def main():
    parser = argparse.ArgumentParser(description='GERGANA DOCUMENT HERE.')
    parser.add_argument('cluster_file', metavar='CLUSTER_FILE', type=str,
                   help='The cluster file.')
    parser.add_argument('nonredundant_file', metavar='NR_FILE', type=str,
                   help='The Nonredundant file.')

    args = parser.parse_args()

    clstrfile = args.cluster_file
    nonredundantfile = args.nonredundant_file

    # refsetfile = "t2clf.antismash.Erin.gb.names.updated2.gb"
    # refsetfile = "t2clf.antismash.Erin.gb.names.updated2.with.pigments.gb" # with pigments

    refsetfile = "/home/gvandova/TypeIIPKS/Blast/Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb" #for KS and CLF, 75 seqs
    
    # For CLF
    #clstrfile = "t2clf.selectKnown12.hmm.hmmsearch.parsed.162.withTandemKS.cdhit.88.clstr"
    #nonredundantfile = "t2clf.selectKnown12.hmm.hmmsearch.parsed.162.withTandemKS.cdhit.88"

    # For KS:
    #clstrfile = "t2ks.selectKnown12.hmm.hmmsearch.parsed.323.withTandemCLF.cdhit.93.clstr"
    #nonredundantfile = "t2ks.selectKnown12.hmm.hmmsearch.parsed.323.withTandemCLF.cdhit.93"

    # For ACP:
    #clstrfile = "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.cdhit.99.clstr"
    #nonredundantfile = "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.cdhit.99"
  
    # For ACPs secod step:
    #clstrfile = "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.clstr"
    #nonredundantfile = "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.cdhit.99.withrefids.cdhit.93"

    # For KR:
    #clstrfile = "t2kr.selectKnown16.hmm.hmmsearch.parsed.34.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.clstr"
    #nonredundantfile = "t2kr.selectKnown16.hmm.hmmsearch.parsed.34.withTandemKSCLF.cdhit.99.withrefids.cdhit.93" 

    # For AT:
    #clstrfile = "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.clstr"
    #nonredundantfile = "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.cdhit.99.withrefids.cdhit.93" 

    #clstrfile = "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.cdhit.95.withrefids.cdhit.95.clstr"
    #nonredundantfile = "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.cdhit.95.withrefids.cdhit.95" 
    
    # For Cyclases
    #clstrfile = "t2cyclase.selectKnown25.hmm.hmmsearch.parsed.10.withTandemKSCLF.cdhit.90.clstr"
    #nonredundantfile = "t2cyclase.selectKnown25.hmm.hmmsearch.parsed.10.withTandemKSCLF.cdhit.90"  

    # For KSIII
    #clstrfile = "t2ksiii.selectKnown35.hmm.hmmsearch.parsed.84.withTandemKSCLF.cdhit.93.clstr"
    #nonredundantfile = "t2ksiii.selectKnown35.hmm.hmmsearch.parsed.84.withTandemKSCLF.cdhit.93"


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

    f1 = open(refsetfile)
    for line in f1.readlines():
        ref_id = line.rstrip()
        refset.add(ref_id)
        missing_ref.add(ref_id)
    # print refset

    # cluster name to set of ids
    clusters = {}
    seq_id_to_cluster = {}
    cluster = None
    f = open(clstrfile)
    for line in f.readlines():
        line = line.strip()
        if line.startswith('>Cluster'):
            cluster = line[1:]
            clusters[cluster] = set()
        else:
            seq_id_coord = line.split('>')[1].split('...')[0]
            clusters[cluster].add(seq_id_coord)
            seq_id_to_cluster[seq_id_coord] = cluster
    
    count = 0
    short_seq_count = 0
    kr_len_cutoff = 0

    nr_id_map = {}
    for nr_id in nonredundant_ids:
        c = seq_id_to_cluster[nr_id]
        synonyms = clusters[c]
        ref_set_id = None
        for s in synonyms:
            seq_id = s.rsplit('_', 1)[0]
            # print seq_id
            if seq_id in refset:
                ref_set_id = s

                if seq_id not in missing_ref:
		    count +=1
#		    print "#################################################################", seq_id, s
		    continue
                missing_ref.remove(seq_id)
                break
	if len(nr_id_to_seq[nr_id]) > kr_len_cutoff:
            if ref_set_id:
                print '>%s' % ref_set_id, '\n', nr_id_to_seq[nr_id]
            else:
                print '>%s' % nr_id, '\n', nr_id_to_seq[nr_id]
	else:
	    short_seq_count += 1
        # print synonyms
    
#    print list(refset - missing_ref)  
#    print missing_ref, len(missing_ref), 78 - len(missing_ref)  # set(['AGSW01000147', 'KC962511'])
#    print count
 #   print "short seq count", short_seq_count 

if __name__ == "__main__":
    main()
