#!/usr/bin/env python
import os


def main():

    # refsetfile = "t2clf.antismash.Erin.gb.names.updated2.gb"
    # refsetfile = "t2clf.antismash.Erin.gb.names.updated2.with.pigments.gb" # with pigments

    # For CLF
    # clstrfile = "t2clf.selectKnown12.hmm.hmmsearch.parsed.150.withTandemKS.cdhit.88.clstr"
    # nonredundantfile = "t2clf.selectKnown12.hmm.hmmsearch.parsed.150.withTandemKS.cdhit.88"

    # # For KS:
    # clstrfile = "t2ks.selectKnown12.hmm.hmmsearch.parsed.300.withTandemCLF.cdhit.93.clstr"
    # nonredundantfile = "t2ks.selectKnown12.hmm.hmmsearch.parsed.300.withTandemCLF.cdhit.93"

    # For ACP:
    refsetfile = "t2acp.antismash.Erin.gb.names.updated2.with.pigments.gb" # for ACP, 68 seqs
    clstrfile = "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKS.cdhit.88.clstr"
    nonredundantfile = "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKS.cdhit.88"

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

    nr_id_map = {}
    for nr_id in nonredundant_ids:
        c = seq_id_to_cluster[nr_id]
        synonyms = clusters[c]
        # print nr_id, c, synonyms
        ref_set_id = None
        for s in synonyms:
            seq_id = s.rsplit('_', 1)[0]
            # print seq_id
            if seq_id in refset:
                ref_set_id = s

                if seq_id in missing_ref:
                    missing_ref.remove(seq_id)
                    break
        if ref_set_id:
            print '>%s' % ref_set_id, '\n', nr_id_to_seq[nr_id]
        else:
            print '>%s' % nr_id, '\n', nr_id_to_seq[nr_id]
        # print synonyms

    # print missing_ref, len(missing_ref)  # set(['AGSW01000147', 'KC962511'])


if __name__ == "__main__":
    main()
