################################################################# 
# HMM search for new t2clfs
#
# Note that HMMs were made using hmmbuild manually in HMM/ 
# See HMM/README
# 

# input blast files
blast_seqs_dir = ../Blast/blast_results_seqs
blast_clf_fasta = $(blast_seqs_dir)/blast_results.CLF.ksclf.fasta
blast_ks_fasta = $(blast_seqs_dir)/blast_results.KS.ksclf.fasta
blast_acp_fasta = $(blast_seqs_dir)/blast_results.ACP.ksacp.fasta
blast_kr_fasta = $(blast_seqs_dir)/blast_results.KR.kskr.fasta
blast_at_fasta = $(blast_seqs_dir)/blast_results.AT.ksat.fasta
blast_ksiii_fasta = $(blast_seqs_dir)/blast_results.KSIII.ksksiii.fasta

#partner = CyclaseABD
partner = CyclaseSRPBCC
#partner = Cyclase
#partner = Cyclase_polyket

blast_$(partner)_fasta = $(blast_seqs_dir)/blast_results.$(partner).ks$(partner).fasta

#partnerkr = C9KR
#partnerkr = C15KR
#partnerkr = C17KR
#partnerkr = C19KR

blast_$(partnerkr)_fasta = $(blast_seqs_dir)/blast_results.KR.kskr.fasta

blast_clf_fasta_cleanname = $(blast_clf_fasta).cleanName
blast_ks_fasta_cleanname = $(blast_ks_fasta).cleanName
blast_acp_fasta_cleanname = $(blast_acp_fasta).cleanName
blast_kr_fasta_cleanname = $(blast_kr_fasta).cleanName
blast_at_fasta_cleanname = $(blast_at_fasta).cleanName
blast_ksiii_fasta_cleanname = $(blast_ksiii_fasta).cleanName
blast_$(partner)_fasta_cleanname = $(blast_$(partner)_fasta).cleanName
#blast_$(partnerkr)_fasta_cleanname = $(blast_$(partnerkr)_fasta).cleanName

# KS
hmm_model_filename_ks = t2ks.selectKnown12.hmm
hmm_model_file_ks = ../pHMM_train/HMM/$(hmm_model_filename_ks)
hmm_out_file_ks = $(hmm_model_filename_ks).hmmsearch
# CLF
hmm_model_filename_clf = t2clf.selectKnown12.hmm
hmm_model_file_clf = ../pHMM_train/HMM/$(hmm_model_filename_clf)
hmm_out_file_clf = $(hmm_model_filename_clf).hmmsearch
# ACP
hmm_model_filename_acp = t2ACP.selectKnown12.hmm
hmm_model_file_acp = ../pHMM_train/HMM/$(hmm_model_filename_acp)
hmm_out_file_acp = $(hmm_model_filename_acp).hmmsearch
# C9 KR
hmm_model_filename_krc9 = KR.Lackner.C9.hmm
hmm_model_file_krc9 = ../pHMM_train/HMM/$(hmm_model_filename_krc9)
hmm_out_file_krc9 = $(hmm_model_filename_krc9).hmmsearch
# C15 KR
hmm_model_filename_krc15 = KR.Lackner.C15.hmm
hmm_model_file_krc15 = ../pHMM_train/HMM/$(hmm_model_filename_krc15)
hmm_out_file_krc15 = $(hmm_model_filename_krc15).hmmsearch
# C17 KR
hmm_model_filename_krc17 = KR.Lackner.C17.hmm
hmm_model_file_krc17 = ../pHMM_train/HMM/$(hmm_model_filename_krc17)
hmm_out_file_krc17 = $(hmm_model_filename_krc17).hmmsearch
# C19 KR
hmm_model_filename_krc19 = KR.Lackner.C19.hmm
hmm_model_file_krc19 = ../pHMM_train/HMM/$(hmm_model_filename_krc19)
hmm_out_file_krc19 = $(hmm_model_filename_krc19).hmmsearch
# AT
hmm_model_filename_at = t2at.selectKnown7.hmm
hmm_model_file_at = ../pHMM_train/HMM/$(hmm_model_filename_at)
hmm_out_file_at = $(hmm_model_filename_at).hmmsearch
# KSIII
hmm_model_filename_ksiii = t2ksiii.selectKnown10.hmm
hmm_model_file_ksiii = ../pHMM_train/HMM/$(hmm_model_filename_ksiii)
hmm_out_file_ksiii = $(hmm_model_filename_ksiii).hmmsearch
# Cyclase
#hmm_model_filename_$(partner) = t2cyclaseABD.selectKnown3.hmm
hmm_model_filename_$(partner) = t2cyclaseSRPBCC.selectKnown17.hmm
#hmm_model_filename_$(partner) = t2cyclase.selectKnown3.hmm
#hmm_model_filename_$(partner) = t2cyclase_polyket.selectKnown6.hmm

hmm_model_file_$(partner) = ../pHMM_train/HMM/$(hmm_model_filename_$(partner))
hmm_out_file_$(partner) = $(hmm_model_filename_$(partner)).hmmsearch

#KRs
#hmm_model_filename_$(partnerkr) = KR.Lackner.C9.hmm
#hmm_model_filename_$(partnerkr) = KR.Lackner.C15.hmm
#hmm_model_filename_$(partnerkr) = KR.Lackner.C17.hmm
#hmm_model_filename_$(partnerkr) = KR.Lackner.C19.hmm

#hmm_model_file_$(partnerkr) = ../pHMM_train/HMM/$(hmm_model_filename_$(partnerkr))
#hmm_out_file_$(partnerkr) = $(hmm_model_filename_$(partnerkr)).hmmsearch


# hmmsearch score cutoffs
hmm_score_cutoff_ks = 323# based on aurachin's score of 324
hmm_score_cutoff_clf = 161# based on aurachin's score of 163, but score in pHMM_search is 161.3
hmm_score_cutoff_acp = 14# based on aurachin's score of 14.9
hmm_score_cutoff_krc9 = 300# to filter out nonC9 KRs
hmm_score_cutoff_krc15 = 300# to filter out nonC9 KRs
hmm_score_cutoff_krc17 = 300# to filter out nonC9 KRs
hmm_score_cutoff_krc19 = 300# to filter out C9 KRs 
hmm_score_cutoff_at = 155# to filter out TypeI ATs
hmm_score_cutoff_ksiii = 62# based on TypeIII KS score of 61.6
hmm_score_cutoff_$(partner) = 50
#hmm_score_cutoff_$(partnerkr) = 300

script_dir = scripts

# Run hmmsearch
$(hmm_out_file_ks): $(blast_ks_fasta_cleanname)
	hmmsearch $(hmm_model_file_ks) $^ > $@

$(hmm_out_file_clf): $(blast_clf_fasta_cleanname)
	hmmsearch $(hmm_model_file_clf) $^ > $@

$(hmm_out_file_acp): $(blast_acp_fasta_cleanname)
	hmmsearch $(hmm_model_file_acp) $^ > $@

$(hmm_out_file_krc9): $(blast_kr_fasta_cleanname)
	hmmsearch $(hmm_model_file_krc9) $^ > $@

$(hmm_out_file_krc15): $(blast_kr_fasta_cleanname)
	hmmsearch $(hmm_model_file_krc15) $^ > $@

$(hmm_out_file_krc17): $(blast_kr_fasta_cleanname)
	hmmsearch $(hmm_model_file_krc17) $^ > $@

$(hmm_out_file_krc19): $(blast_kr_fasta_cleanname)
	hmmsearch $(hmm_model_file_krc19) $^ > $@

$(hmm_out_file_at): $(blast_at_fasta_cleanname)
	hmmsearch $(hmm_model_file_at) $^ > $@

$(hmm_out_file_ksiii): $(blast_ksiii_fasta_cleanname)
	hmmsearch $(hmm_model_file_ksiii) $^ > $@

$(hmm_out_file_$(partner)): $(blast_$(partner)_fasta_cleanname)
	hmmsearch $(hmm_model_file_$(partner)) $^ > $@

#$(hmm_out_file_$(partnerkr)): $(blast_$(partnerkr)_fasta_cleanname)
#	hmmsearch $(hmm_model_file_$(partnerkr)) $^ > $@

run_hmmsearch: $(hmm_out_file_ks) $(hmm_out_file_clf) $(hmm_out_file_acp)  $(hmm_out_file_at) $(hmm_out_file_ksiii) $(hmm_out_file_$(partner))

# Parse output
hmm_parsed_file_ks = $(hmm_model_filename_ks).hmmsearch.parsed
hmm_parsed_file_clf = $(hmm_model_filename_clf).hmmsearch.parsed
hmm_parsed_file_acp = $(hmm_model_filename_acp).hmmsearch.parsed
hmm_parsed_file_krc9 = $(hmm_model_filename_krc9).hmmsearch.parsed
hmm_parsed_file_krc15 = $(hmm_model_filename_krc15).hmmsearch.parsed
hmm_parsed_file_krc17 = $(hmm_model_filename_krc17).hmmsearch.parsed
hmm_parsed_file_krc19 = $(hmm_model_filename_krc19).hmmsearch.parsed
hmm_parsed_file_at = $(hmm_model_filename_at).hmmsearch.parsed
hmm_parsed_file_ksiii = $(hmm_model_filename_ksiii).hmmsearch.parsed
hmm_parsed_file_$(partner) = $(hmm_model_filename_$(partner)).hmmsearch.parsed
#hmm_parsed_file_$(partnerkr) = $(hmm_model_filename_$(partnerkr)).hmmsearch.parsed

$(hmm_parsed_file_ks): $(hmm_out_file_ks)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_clf): $(hmm_out_file_clf)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_acp): $(hmm_out_file_acp)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_krc9): $(hmm_out_file_krc9)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_krc15): $(hmm_out_file_krc15)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_krc17): $(hmm_out_file_krc17)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_krc19): $(hmm_out_file_krc19)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_at): $(hmm_out_file_at)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_ksiii): $(hmm_out_file_ksiii)
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_$(partner)): $(hmm_out_file_$(partner))
	perl $(script_dir)/parseHMM.pl $^ > $@

$(hmm_parsed_file_$(partnerkr)): $(hmm_out_file_$(partnerkr))
	perl $(script_dir)/parseHMM.pl $^ > $@

hmmsearch_parse: $(hmm_parsed_file_ks) $(hmm_parsed_file_clf) \
		 $(hmm_parsed_file_acp) \
		 $(hmm_parsed_file_at) \
		 $(hmm_parsed_file_krc9) \
		 $(hmm_parsed_file_krc15) \
		 $(hmm_parsed_file_krc17) \
		 $(hmm_parsed_file_krc19) \
		 $(hmm_parsed_file_ksiii) \
		 $(hmm_parsed_file_$(partner))

# Filter results according to selected hmmsearch cutoff score
hmm_filtered_file_ks = $(hmm_model_filename_ks).hmmsearch.parsed.$(hmm_score_cutoff_ks)
hmm_filtered_file_clf = $(hmm_model_filename_clf).hmmsearch.parsed.$(hmm_score_cutoff_clf)
hmm_filtered_file_acp = $(hmm_model_filename_acp).hmmsearch.parsed.$(hmm_score_cutoff_acp)
hmm_filtered_file_krc9 = $(hmm_model_filename_krc9).hmmsearch.parsed.$(hmm_score_cutoff_krc9)
hmm_filtered_file_krc15 = $(hmm_model_filename_krc15).hmmsearch.parsed.$(hmm_score_cutoff_krc15)
hmm_filtered_file_krc17 = $(hmm_model_filename_krc17).hmmsearch.parsed.$(hmm_score_cutoff_krc17)
hmm_filtered_file_krc19 = $(hmm_model_filename_krc19).hmmsearch.parsed.$(hmm_score_cutoff_krc19)
hmm_filtered_file_at = $(hmm_model_filename_at).hmmsearch.parsed.$(hmm_score_cutoff_at)
hmm_filtered_file_ksiii = $(hmm_model_filename_ksiii).hmmsearch.parsed.$(hmm_score_cutoff_ksiii)
hmm_filtered_file_$(partner) = $(hmm_model_filename_$(partner)).hmmsearch.parsed.$(hmm_score_cutoff_$(partner))
#hmm_filtered_file_$(partnerkr) = $(hmm_model_filename_$(partnerkr)).hmmsearch.parsed.$(hmm_score_cutoff_$(partnerkr))

$(hmm_filtered_file_ks): $(hmm_parsed_file_ks)
	cat $^ \
	| perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_ks));'\
	> $@; \

$(hmm_filtered_file_clf): $(hmm_parsed_file_clf)
	cat $^ \
	| perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_clf));'\
	> $@; \

$(hmm_filtered_file_acp): $(hmm_parsed_file_acp)
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_acp));'\
        > $@; \

$(hmm_filtered_file_krc9): $(hmm_parsed_file_krc9)
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_krc9));'\
        > $@; \

$(hmm_filtered_file_krc15): $(hmm_parsed_file_krc15)
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_krc15));'\
        > $@; \

$(hmm_filtered_file_krc17): $(hmm_parsed_file_krc17)
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_krc17));'\
        > $@; \

$(hmm_filtered_file_krc19): $(hmm_parsed_file_krc19)
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_krc19));'\
        > $@; \

$(hmm_filtered_file_at): $(hmm_parsed_file_at)
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_at));'\
        > $@; \

$(hmm_filtered_file_ksiii): $(hmm_parsed_file_ksiii)
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_ksiii));'\
        > $@; \

$(hmm_filtered_file_$(partner)): $(hmm_parsed_file_$(partner))
	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_$(partner)));'\
        > $@; \

#$(hmm_filtered_file_$(partnerkr)): $(hmm_parsed_file_$(partnerkr))
#	cat $^ \
        | perl -anF/"\t"/ -e 'print "$$_" if ($$F[8] > $(hmm_score_cutoff_$(partner)));'\
        > $@; \


filter: $(hmm_filtered_file_ks) $(hmm_filtered_file_clf) \
	$(hmm_filtered_file_acp) \
	$(hmm_filtered_file_at) \
	$(hmm_filtered_file_krc9) \
	$(hmm_filtered_file_krc15) \
	$(hmm_filtered_file_krc17) \
	$(hmm_filtered_file_krc19) \
	$(hmm_filtered_file_ksiii) \
	$(hmm_filtered_file_$(partner)) \
	$(hmm_filtered_file_$(partnerkr))

clean: 
	rm $(hmm_out_file_ks) $(hmm_out_file_clf) $(hmm_out_file_acp) 
	rm $(hmm_parsed_file_ks) $(hmm_parsed_file_clf) $(hmm_parsed_file_acp)
	rm $(hmm_filtered_file_ks) $(hmm_filtered_file_clf) $(hmm_filtered_file_acp)


################################################################# 
# Fasta seqs from HMM results using to count unique sequences

# KS fasta
$(hmm_filtered_file_ks).fasta: $(hmm_filtered_file_ks)
	cat $^ \
	| $(script_dir)/multistab2fasta.pl $^ > $@

# CLF fasta
$(hmm_filtered_file_clf).fasta: $(hmm_filtered_file_clf)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

# ACP fasta
$(hmm_filtered_file_acp).fasta: $(hmm_filtered_file_acp)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

$(hmm_filtered_file_krc9).fasta: $(hmm_filtered_file_krc9)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

$(hmm_filtered_file_krc15).fasta: $(hmm_filtered_file_krc15)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

$(hmm_filtered_file_krc17).fasta: $(hmm_filtered_file_krc17)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

$(hmm_filtered_file_krc19).fasta: $(hmm_filtered_file_krc19)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

# AT fasta
$(hmm_filtered_file_at).fasta: $(hmm_filtered_file_at)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

#KSIII fasta
$(hmm_filtered_file_ksiii).fasta: $(hmm_filtered_file_ksiii)
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

#Cyclases fasta
$(hmm_filtered_file_$(partner)).fasta: $(hmm_filtered_file_$(partner))
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

#KRs fasta
#$(hmm_filtered_file_$(partnerkr)).fasta: $(hmm_filtered_file_$(partnerkr))
#	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@


#CleanSeq (remove dashes introduced during the hmm searcg)
name_length = 200
$(hmm_filtered_file_ks).cleanSeq.fasta: $(hmm_filtered_file_ks).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_clf).cleanSeq.fasta: $(hmm_filtered_file_clf).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_acp).cleanSeq.fasta: $(hmm_filtered_file_acp).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_krc9).cleanSeq.fasta: $(hmm_filtered_file_krc9).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_krc15).cleanSeq.fasta: $(hmm_filtered_file_krc15).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_krc17).cleanSeq.fasta: $(hmm_filtered_file_krc17).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_krc19).cleanSeq.fasta: $(hmm_filtered_file_krc19).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_at).cleanSeq.fasta: $(hmm_filtered_file_at).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_ksiii).cleanSeq.fasta: $(hmm_filtered_file_ksiii).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

$(hmm_filtered_file_$(partner)).cleanSeq.fasta: $(hmm_filtered_file_$(partner)).fasta
	perl $(script_dir)/cleanSeq.pl $^ > $@

#$(hmm_filtered_file_$(partnerkr)).cleanSeq.fasta: $(hmm_filtered_file_$(partnerkr)).fasta
#	perl $(script_dir)/cleanSeq.pl $^ > $@


# Use cdhit to eliminate identical sequences
cdhit_cutoff = .99
cdhit_bin = ~maureenh/Cdhit/cd-hit-v4.6.1-2012-08-27/cd-hit

$(hmm_filtered_file_ks).cdhit$(cdhit_cutoff): $(hmm_filtered_file_ks).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_clf).cdhit$(cdhit_cutoff): $(hmm_filtered_file_clf).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_acp).cdhit$(cdhit_cutoff): $(hmm_filtered_file_acp).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_krc9).cdhit$(cdhit_cutoff): $(hmm_filtered_file_krc9).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_krc15).cdhit$(cdhit_cutoff): $(hmm_filtered_file_krc15).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_krc17).cdhit$(cdhit_cutoff): $(hmm_filtered_file_krc17).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_krc19).cdhit$(cdhit_cutoff): $(hmm_filtered_file_krc19).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_at).cdhit$(cdhit_cutoff): $(hmm_filtered_file_at).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_ksiii).cdhit$(cdhit_cutoff): $(hmm_filtered_file_ksiii).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(hmm_filtered_file_$(partner)).cdhit$(cdhit_cutoff): $(hmm_filtered_file_$(partner)).cleanSeq.fasta
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

#$(hmm_filtered_file_$(partnerkr)).cdhit$(cdhit_cutoff): $(hmm_filtered_file_$(partnerkr)).cleanSeq.fasta
#	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

cdhit: $(hmm_filtered_file_ks).cdhit$(cdhit_cutoff) $(hmm_filtered_file_clf).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_acp).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_at).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_krc9).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_krc15).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_krc17).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_krc19).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_ksiii).cdhit$(cdhit_cutoff) \
       $(hmm_filtered_file_$(partner)).cdhit$(cdhit_cutoff)

all: run_hmmsearch hmmsearch_parse filter cdhit
