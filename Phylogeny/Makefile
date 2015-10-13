# Run mafft and fasttree on various sequence sets


#############################################################
# Mafft and fasttree on blast result seqs 
# Read from ../Blast, but print output to this dir
# TODO:  Run cdhit to eliminate nearly-identical seqs in the Blast dir

blast_seqs_dir = ../Blast/blast_results_seqs
blast_ks_filename = blast_results.KS.fasta.cleanName.cdhit.99
blast_clf_filename = blast_results.CLF.fasta.cleanName.cdhit.99
blast_kr_filename = blast_results.KR.fasta.cleanName.cdhit.99
blast_at_filename = blast_results.AT.fasta.cleanName.cdhit.99
blast_cyclase_filename = blast_results.Cyclase.fasta.cleanName.cdhit.99
blast_ksiii_filename = blast_results.KSIII.fasta.cleanName.cdhit.99

blast_ks_file = $(blast_seqs_dir)/$(blast_ks_filename)
blast_clf_file = $(blast_seqs_dir)/$(blast_clf_filename)
blast_kr_file = $(blast_seqs_dir)/$(blast_kr_filename)
blast_at_file = $(blast_seqs_dir)/$(blast_at_filename)
blast_cyclase_file = $(blast_seqs_dir)/$(blast_cyclase_filename)
blast_ksiii_file = $(blast_seqs_dir)/$(blast_ksiii_filename)

input_fasta_file = $(blast_ks_file)
mafft_file = $(blast_ks_filename).mafft
fasttree_file = $(mafft_file).FastTree



#############################################################
# Mafft and fasttree on the pHMM result sequences
# Read from ../pHMM_search, but print output to this dir

hmm_dir = ../pHMM_search
hmm_ks_filename = t2ks.selectKnown12.hmm.hmmsearch.parsed.300.cdhit.99
hmm_clf_filename = t2clf.selectKnown12.hmm.hmmsearch.parsed.150.cdhit.99
hmm_ks_file = $(hmm_dir)/$(hmm_ks_filename)
hmm_clf_file = $(hmm_dir)/$(hmm_clf_filename)

input_fasta_file = $(hmm_ks_file)
mafft_file = $(hmm_ks_filename).mafft
fasttree_file = $(mafft_file).FastTree




#############################################################
# Mafft and fasttree on the non-redundant set of clusters
# TODO:  Add an outgroup (FabF?  FabH?  T1pks?) into the fasta file, in order to provide a sequence upon which to root

#nr_dir = ../KSCLF_tandem
nr_dir = ~gvandova/TypeIIPKS/KSCLF_tandem
nr_clf_filename = t2clf.selectKnown12.hmm.hmmsearch.parsed.150.withTandemKS.cdhit.87.withFabF
nr_clf_file = $(nr_dir)/$(nr_clf_filename)

input_fasta_file = $(nr_clf_file)
mafft_file = $(nr_clf_filename).mafft
fasttree_file = $(mafft_file).FastTree



################################################################
# Run mafft and fastree on whatever was defined above as 
#  the input_fasta, mafft and fasttree files

mafft_bin = /usr/local/bin/mafft --thread 50
fasttree_bin = ~maureenh/FastTree/FastTreeMP

$(mafft_file): $(input_fasta_file)
	$(mafft_bin) $^ > $@; \

$(fasttree_file): $(mafft_file)
	$(fasttree_bin) $^ > $@; \



tree: $(fasttree_file)
