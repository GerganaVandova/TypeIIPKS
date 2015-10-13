#!/usr/bin/env python
import os
import argparse


def main():

    parser = argparse.ArgumentParser(description='To run the script: \
                python scripts/get_erin_ids_seqs.py \
                <clstr file> \
                <nonredundant file> \
                <tandem file> \
                <domain type> \
                Example: python scripts/get_erin_ids_seqs.py \
                t2clf.selectKnown12.hmm.hmmsearch.parsed.161.withTandemKS.cdhit.88.clstr \
                t2clf.selectKnown12.hmm.hmmsearch.parsed.161.withTandemKS.cdhit.88 \
                t2ks.selectKnown12.hmm.323.t2clf.selectKnown12.hmm.161.nearby.2000b.totalSpan.1500 \
                CLF')
    parser.add_argument('cluster_file', metavar='CLUSTER_FILE', type=str,
                        help='The cluster file.')
    parser.add_argument('nonredundant_file', metavar='NR_FILE', type=str,
                        help='The Nonredundant file.')
    parser.add_argument('ksclf_tandem_file', metavar='KSCLF_FILE', type=str,
                        help='The KSCLF_tandem file.')
    parser.add_argument('domain_name', metavar='DOMAIN', type=str,
                        help='KS or partner domain')
    args = parser.parse_args()

    domain = args.domain_name
    clstrfile = args.cluster_file
    nonredundantfile = args.nonredundant_file
    ksclf_tandemfile = args.ksclf_tandem_file

    refsetfile = "/home/gvandova/TypeIIPKS/Blast/Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb"
    #refsetfile = "t2clf.antismash.Erin.gb.names.78.gb" #  when testing on my laptop

    nonredundant_ids = []
    nr_id_to_seq = {}

    # read nonredundant file
    from Bio import SeqIO
    handle = open(nonredundantfile, "r")
    for record in SeqIO.parse(handle, "fasta"):
        nr_id_to_seq[record.id] = record.seq
        nonredundant_ids.append(record.id)
    handle.close()

    # read KSCLF tandem file
    ks_id_coord_to_seq = {}
    clf_id_coord_to_seq = {}

    f = open(ksclf_tandemfile)
    for line in f.readlines():
        ksclf_id, ks_coord, ks_seq, clf_coord, clf_seq = line.split("\t")
        ks_seq = ks_seq.strip()
        clf_seq = clf_seq.strip()
        ks_id_coord = ksclf_id + "_" + ks_coord
        clf_id_coord = ksclf_id + "_" + clf_coord
        ks_id_coord_to_seq[ks_id_coord] = ks_seq
        clf_id_coord_to_seq[clf_id_coord] = clf_seq

    # read red id file
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

    # read cluster file
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
                    count += 1
#                    print "######################################", seq_id, s
                    continue
                missing_ref.remove(seq_id)
                break

        if ref_set_id:
            if domain == "KS":
                print '>%s' % ref_set_id, '\n', ks_id_coord_to_seq[ref_set_id]
            else:
                print '>%s' % ref_set_id, '\n', clf_id_coord_to_seq[ref_set_id]
        else:
            print '>%s' % nr_id, '\n', nr_id_to_seq[nr_id]

    #print list(refset - missing_ref)
    print "found from refset:", list(refset - missing_ref), "\nmissing from refset:", missing_ref, "\nnum missing:", len(missing_ref), "\nnum found:", 78 - len(missing_ref)
    #print count

if __name__ == "__main__":
    main()
