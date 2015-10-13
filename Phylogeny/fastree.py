#!/usr/bin/env python
import os
import subprocess


def make_tree(folder, input_fasta_filename):
	
    mafft_file = os.path.join(folder, input_fasta_filename + ".mafft")
    mafft_input_file = os.path.join(folder, input_fasta_filename)
    f1 = open(mafft_file, "w")
    subprocess.call(["/usr/local/bin/mafft", "--thread", "64", mafft_input_file], stdout=f1) #call mafft

    fasttree_file = os.path.join(folder, input_fasta_filename + ".mafft.FastTree")
    f2 = open(fasttree_file, "w")
    subprocess.call(["/home/maureenh/FastTree/FastTreeMP", mafft_file], stdout=f2) #call fasttree


variables = [("../KSCLF_tandem", "t2ks.selectKnown12.hmm.hmmsearch.parsed.323.withTandemCLF.cdhit.93.withrefseqs.withFabF",
                                 "t2clf.selectKnown12.hmm.hmmsearch.parsed.161.withTandemKS.cdhit.88.withrefseqs.withFabF.mod",
                                 "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs.withEcoliACP",
                                 "KR.Lackner.C9.hmm.hmmsearch.parsed.300.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs.witheryKR",
				 "KR.Lackner.C15.hmm.hmmsearch.parsed.300.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs.witheryKR",
				 "KR.Lackner.C17.hmm.hmmsearch.parsed.300.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs.witheryKR",
				 "KR.Lackner.C19.hmm.hmmsearch.parsed.300.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs.witheryKR",				 
				 "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs.withFabD",
                                 "t2ksiii.selectKnown10.hmm.hmmsearch.parsed.62.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs.withFabF",
                                 "t2cyclaseABD.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs",
                                 "t2cyclaseSRPBCC.selectKnown17.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs",
                                 "t2cyclase.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs",
                                 "t2cyclase_polyket.selectKnown6.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefseqs.cdhit.93.withrefseqs"
            )]


#variables = [("../Blast/blast_results_seqs", "blast_results.KS.fasta.cleanName.cdhit.99", "blast_results.CLF.fasta.cleanName.cdhit.99")]

#variables = [("../KSCLF_tandem", "t2clf.selectKnown12.hmm.hmmsearch.parsed.150.withTandemKS.cdhit.87.withFabF", "t2ks.selectKnown12.hmm.hmmsearch.parsed.300.withTandemCLF.cdhit.93.withFabF"),
#	     ("../pHMM_search", "t2ks.selectKnown12.hmm.hmmsearch.parsed.300.cdhit.99", "t2clf.selectKnown12.hmm.hmmsearch.parsed.150.cdhit.99")]

#Run Mafft and fasttree on the non-redundant set of clusters
for folder, ks, clf, acp, krc9, krc15, krc17, krc19, at, ksiii, cyc1, cyc2, cyc3, cyc4 in variables:
#     make_tree(folder, ks)
#     make_tree(folder, clf)
#     make_tree(folder, acp)
      make_tree(folder, krc9)
      make_tree(folder, krc15)
      make_tree(folder, krc17)
      make_tree(folder, krc19)
#     make_tree(folder, at)
#     make_tree(folder, ksiii)
#     make_tree(folder, cyc1)
#     make_tree(folder, cyc2)
#     make_tree(folder, cyc3)
#     make_tree(folder, cyc4)	
