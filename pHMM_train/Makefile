################################################################################################################################## 
# Compare 5 pHMMs interms of how they score:
# 1.  a positive training set (known Type II KS and CLFs)
# 2.  a negative training set (type I, FabF, FabH, etc)
# Set of HMMs tested (for now):
# t2ACP.selectknown12.hmm
#  t2ks.Erin.60.hmm
#  t2ks.selectKnown12.hmm
#  t2ks.antismash.25.hmm
#  t2ks.C16.hmm
#  t2ks.C28.hmm
# Choose cutoff by testing HMMs against positive and negative train sets
# HMMs were made manually (or in a README) and stored in the dir HMM/

hmm_dir = HMM
#hmm_dir = HMM_CLF
#hmm_dir = HMM_ACP #dir for ACP hmm only
# Positive training sets
fasta_dir = FastaTestSets

# Store results of hmmer search in these dirs
hmm_run_dir = $(hmm_dir).hmmsearch.$(fasta_dir)

# Store results of parsed hmmer results in these dirs.
# These parsed results can be read by R.
hmm_parse_dir = $(hmm_run_dir).parse

script_dir = scripts

# hmmsearch the selected hmms  vs. selected fasta files
$(hmm_run_dir): $(hmm_dir) $(fasta_dir)
	perl $(script_dir)/searchHMMs.pl $^ $@; \

$(hmm_parse_dir): $(hmm_run_dir) $(fasta_dir)
	perl $(script_dir)/parseHMMsScores.pl $^ $@; \

hmmsearch: $(hmm_run_dir) $(hmm_parse_dir)
