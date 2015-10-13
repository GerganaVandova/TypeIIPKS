# Grab sequences from NCBI

script_dir = scripts

#filename = t2clf.selectKnown12.hmm.hmmsearch.parsed.161.withTandemKS.fasta###### GV is this right?
#filename = t2ks.selectKnown12.hmm.hmmsearch.parsed.323.withTandemCLF.fasta
#filename = t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.fasta
#filename = t2kr.selectKnown16.hmm.hmmsearch.parsed.34.withTandemKSCLF.fasta
#filename = t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.fasta
#filename = t2ksiii.selectKnown10.hmm.hmmsearch.parsed.62.withTandemKSCLF.fasta
#filename = t2cyclaseABD.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.fasta
filename = t2cyclaseSRPBCC.selectKnown17.hmm.hmmsearch.parsed.20.withTandemKSCLF.fasta
#filename = t2cyclase.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.fasta
#filename = t2cyclase_polyket.selectKnown6.hmm.hmmsearch.parsed.50.withTandemKSCLF.fasta

indir = ~gvandova/TypeIIPKS/KSCLF_tandem
infile = $(indir)/$(filename)

id_list_file = $(filename).ids

# Get fasta headers and
# remove digits-digits (coords)
# and remove >
$(id_list_file): $(infile)
	cat $^ \
	| grep '>' \
	| sed 's/_[[:digit:]]\+-[[:digit:]]\+//' \
	| sed 's/>//' \
	> $@; \

id: $(id_list_file)

# Fetch the genbank files using Bioperl
gb_dir = $(filename).gbwithparts
$(gb_dir): $(id_list_file)
	perl $(script_dir)/fetchIndivGenbanks.pl $^ gbwithparts $@; \

fetch: $(gb_dir)

##########################################################################
# Get the phylum information from the protein genbank file
$(gb_dir).phyla: $(gb_dir)
	perl $(script_dir)/taxonomyFromGenbanks.pl $^ 2 > $@; \

# convert genbankid phylum to 
# clfid (genbank+coords) phylum

col1 = 0# column that has the genbank id
col2 = 1# column that has the information to be joined to the fasta id
$(filename).phyla: $(infile) $(gb_dir).phyla
	perl $(script_dir)/mapFastaIDtoInfo.pl $^ $(col1) $(col2) > $@; \

phyla:  $(filename).phyla

# New Mar 27 2015
# Get the genbank description information from the protein genbank file
$(gb_dir).desc: $(gb_dir)
	perl $(script_dir)/getAccessionDescHeader.pl $^ > $@; \

desc: $(gb_dir).desc

all: id fetch phyla
