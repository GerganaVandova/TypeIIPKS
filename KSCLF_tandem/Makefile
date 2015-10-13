# Find KS+CLF in tandem, within 1kb of each other, with >1.5kb total span (to eliminate those KS/CLF pHMMs matching the same 1kb gene)

script_dir = scripts

hmm_model_filename_ks = t2ks.selectKnown12.hmm
hmm_model_filename_clf = t2clf.selectKnown12.hmm
#hmm_model_filename_partner = t2ACP.selectKnown12.hmm
#hmm_model_filename_partner = t2at.selectKnown7.hmm
#hmm_model_filename_partner = t2ksiii.selectKnown10.hmm

#hmm_model_filename_partner = KR.Lackner.C9.hmm
#hmm_model_filename_partner = KR.Lackner.C15.hmm
#hmm_model_filename_partner = KR.Lackner.C17.hmm
hmm_model_filename_partner = KR.Lackner.C19.hmm

#hmm_model_filename_partner = t2cyclaseABD.selectKnown3.hmm
#hmm_model_filename_partner = t2cyclaseSRPBCC.selectKnown17.hmm
#hmm_model_filename_partner = t2cyclase.selectKnown3.hmm
#hmm_model_filename_partner = t2cyclase_polyket.selectKnown6.hmm

# hmmsearch score cutoffs
hmm_score_cutoff_ks = 323# based on aurachin's score of 324
hmm_score_cutoff_clf = 161# based on aurachin's score, but aur score = 161.3 after pHMMsearch
#hmm_score_cutoff_partner = 14# ACP based on ACP aurachin's score
hmm_score_cutoff_partner = 300# All KRs based on FabG  score  
#hmm_score_cutoff_partner = 155# AT based on TypeI AT score
#hmm_score_cutoff_partner = 62# KSIII based on TypeII KS score 
#hmm_score_cutoff_partner = 50# All cyclases

#Roots for phylogenetic trees
root_ksclf = FabF# KS, CLF root
#root_partner = EcoliACP# ACP root
root_partner = eryKR# KR root
#root_partner = FabD# AT root
#root_partner = FabF# KSIII root


# Input file, result of hmmsearch in previous step
input_dir = ../pHMM_search
hmm_filtered_filename_ks = $(hmm_model_filename_ks).hmmsearch.parsed.$(hmm_score_cutoff_ks)
hmm_filtered_filename_clf = $(hmm_model_filename_clf).hmmsearch.parsed.$(hmm_score_cutoff_clf)
hmm_filtered_filename_partner = $(hmm_model_filename_partner).hmmsearch.parsed.$(hmm_score_cutoff_partner)

hmm_filtered_file_ksclf = hmm_filtered_file_ksclf_tandem

hmm_filtered_file_ks = $(input_dir)/$(hmm_filtered_filename_ks)
hmm_filtered_file_clf = $(input_dir)/$(hmm_filtered_filename_clf)
hmm_filtered_file_partner = $(input_dir)/$(hmm_filtered_filename_partner)

# Cutoffs to filter KS+CLF in tandem
near_cutoff = 2000
near_cutoff_partner = 30000
total_span_cutoff = 1500# eliminate overlapping KS, KSIII  and CLF hits on same gene
total_span_cutoff_partner = 0# for all the other domains

#filter KS+CLF in tandem
hmm_filtered_file_ksclf_nearby = $(hmm_model_filename_ks).$(hmm_score_cutoff_ks).$(hmm_model_filename_clf).$(hmm_score_cutoff_clf).nearby.$(near_cutoff)b.totalSpan.$(total_span_cutoff)
$(hmm_filtered_file_ksclf_nearby): $(hmm_filtered_file_ks) $(hmm_filtered_file_clf)
	perl $(script_dir)/findKSCLFnearbyTotalSpan.pl $^ \
        $(near_cutoff) \
        $(total_span_cutoff) \
        > $@

# Run the search for KSCLF + partner in tandem
hmm_filtered_file_ksclf_partner_nearby = $(hmm_model_filename_ks).$(hmm_score_cutoff_ks).$(hmm_model_filename_clf).$(hmm_score_cutoff_clf).$(hmm_model_filename_partner).$(hmm_score_cutoff_partner).nearby.$(near_cutoff_partner)b.totalSpan.$(total_span_cutoff_partner)

$(hmm_filtered_file_ksclf_partner_nearby): $(hmm_filtered_file_ksclf) $(hmm_filtered_file_partner)
	perl $(script_dir)/findKSCLFnearbyTotalSpan.pl $^ \
        $(near_cutoff_partner) \
        $(total_span_cutoff_partner) \
        > $@

tandem_ksclf: $(hmm_filtered_file_ksclf_nearby)

$(hmm_filtered_file_ksclf): $(hmm_filtered_file_ksclf_nearby)
	python $(script_dir)/parse_hmm.py $^ > $@

tandem_partner: $(hmm_filtered_file_ksclf_partner_nearby) $(hmm_filtered_file_ksclf)


# Compare the Erin set to the found set - found them all?
erin_dir = ~/TypeIIPKS/Blast/Erin/Manual
erin_file = $(erin_dir)/t2clf.antismash.Erin.gb.names.78.gb #78 sequences, updated April 28, 2015

$(hmm_filtered_file_ksclf_nearby).compareErin: $(hmm_filtered_file_ksclf_nearby) $(erin_file)
	perl $(script_dir)/compareErin.pl $^ \
	> $@

$(hmm_filtered_file_ksclf_partner_nearby).compareErin: $(hmm_filtered_file_ksclf_partner_nearby) $(erin_file)
	perl $(script_dir)/compareErin.pl $^ \
        > $@

erin: $(hmm_filtered_file_ksclf_nearby).compareErin
erin_partner: $(hmm_filtered_file_ksclf_partner_nearby).compareErin


#Separate KS, CLF, and partner domains in tab-delimited sequence files
$(hmm_filtered_filename_ks).withTandemCLF: $(hmm_filtered_file_ksclf_nearby)
	cut -f 1,2,3 $^ \
	> $@

$(hmm_filtered_filename_clf).withTandemKS: $(hmm_filtered_file_ksclf_nearby)
	cut -f 1,4,5 $^ \
	> $@

$(hmm_filtered_filename_partner).withTandemKSCLF: $(hmm_filtered_file_ksclf_partner_nearby)
	cut -f 1,4,5 $^ \
        > $@


# Make fasta file of KS, CLF, and partner domain seqs
$(hmm_filtered_filename_ks).withTandemCLF.fasta: $(hmm_filtered_filename_ks).withTandemCLF
	cat $^ \
	| $(script_dir)/multistab2fasta.pl $^ > $@

$(hmm_filtered_filename_clf).withTandemKS.fasta: $(hmm_filtered_filename_clf).withTandemKS
	cat $^ \
	| $(script_dir)/multistab2fasta.pl $^ > $@

$(hmm_filtered_filename_partner).withTandemKSCLF.fasta: $(hmm_filtered_filename_partner).withTandemKSCLF
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@
#fasta: $(hmm_filtered_filename_ks).withTandemCLF.fasta $(hmm_filtered_filename_clf).withTandemKS.fasta
fasta: $(hmm_filtered_filename_partner).withTandemKSCLF.fasta


# Clean sequences to remove dashes (only necessary with old data)
$(hmm_filtered_filename_clf).withTandemKS.cleanSeq.fasta: $(hmm_filtered_filename_clf).withTandemKS.fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_filename_ks).withTandemCLF.cleanSeq.fasta: $(hmm_filtered_filename_ks).withTandemCLF.fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_filename_partner).withTandemKSCLF.cleanSeq.fasta: $(hmm_filtered_filename_partner).withTandemKSCLF.fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@


# Eliminate identical KS/CLFs from this set (because started from overly-redundant step.  TODO correct that in ../pHMM_search)
cdhit_cutoff_ks = .93#for KSs
cdhit_cutoff_clf = .88#for CLFs to keep X87093 urdamycin and KC962511 grincamycin
cdhit_cutoff_partner = .99
cdhit_cutoff_partner2 = .93

cdhit_bin = ~maureenh/Cdhit/cd-hit-v4.6.1-2012-08-27/cd-hit
name_length = 200

$(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf): $(hmm_filtered_filename_clf).withTandemKS.cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff_clf) -d $(name_length)

$(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks): $(hmm_filtered_filename_ks).withTandemCLF.cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff_ks) -d $(name_length)

$(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner): $(hmm_filtered_filename_partner).withTandemKSCLF.cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff_partner) -d $(name_length)

cdhit: $(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf) \
       $(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks) \
       $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner)


#Add reference ids and sequences to the nonredundant files
$(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks).withrefseqs: $(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks)
	python $(script_dir)/get_erin_ids_seqs.py $^.clstr $^ $(hmm_filtered_file_ksclf_nearby) KS > $@

$(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf).withrefseqs: $(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf)
	python $(script_dir)/get_erin_ids_seqs.py $^.clstr $^ $(hmm_filtered_file_ksclf_nearby) CLF > $@

$(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs: $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner)
	python $(script_dir)/get_erin_ids_seqs.py $^.clstr $^ $(hmm_filtered_file_ksclf_partner_nearby) Partner > $@

refseqs: $(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks).withrefseqs $(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf).withrefseqs $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs


# Clean sequences to remove dashes for second cdhit step for partner domains
$(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cleanSeq.fasta: $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs
	perl $(script_dir)/cleanSeq.pl $^ > $@

#Second cdhit for partner domains
$(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2): $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff_partner2) -d $(name_length)

#Second addiotion of ref ids ans seqs for partner domains
$(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2).withrefseqs: $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2)
	python $(script_dir)/get_erin_ids_seqs.py $^.clstr $^ $(hmm_filtered_file_ksclf_partner_nearby) Partner > $@

refseqs2: $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2).withrefseqs

#Add rootsfor phylogenetic trees
$(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks).withrefseqs.with$(root_ksclf): $(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks).withrefseqs
	cat roots/$(root_ksclf) $^ > $@

$(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf).withrefseqs.with$(root_ksclf): $(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf).withrefseqs
	cat roots/$(root_ksclf) $^ > $@

$(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2).withrefseqs.with$(root_partner): $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2).withrefseqs
	cat roots/$(root_partner) $^ > $@

root: $(hmm_filtered_filename_ks).withTandemCLF.cdhit$(cdhit_cutoff_ks).withrefseqs.with$(root_ksclf) \
      $(hmm_filtered_filename_clf).withTandemKS.cdhit$(cdhit_cutoff_clf).withrefseqs.with$(root_ksclf) \
      $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2).withrefseqs.with$(root_partner)

rootkr: $(hmm_filtered_filename_partner).withTandemKSCLF.cdhit$(cdhit_cutoff_partner).withrefseqs.cdhit$(cdhit_cutoff_partner2).withrefseqs.with$(root_partner)
all: tandem_partner erin erin_partner cdhit refseqs refseqs2 root

#Run without make root for cyclases
#all: tandem_partner erin erin_partner cdhit refseqs refseqs2


clean:
	rm -f t2*select*
	rm -f hmm_filtered_file_ksclf_tandem





