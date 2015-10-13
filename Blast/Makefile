#################################################################
# New Feb 27
# Cat all files into one

script_dir = scripts
parse_blast_dir = blast_results_parse
blast_seqs_dir = blast_results_seqs
blast_results_tab_clf_file = $(blast_seqs_dir)/blast_results.parsed.CLF.9f
blast_results_tab_ks_file = $(blast_seqs_dir)/blast_results.parsed.KS.9f
blast_results_tab_acp_file = $(blast_seqs_dir)/blast_results.parsed.ACP.9f
blast_results_tab_kr_file = $(blast_seqs_dir)/blast_results.parsed.KR.9f
blast_results_tab_at_file = $(blast_seqs_dir)/blast_results.parsed.AT.9f
blast_results_tab_ksiii_file = $(blast_seqs_dir)/blast_results.parsed.KSIII.9f

#partner = CyclaseABD
partner = CyclaseSRPBCC
#partner = Cyclase
#partner = Cyclase_polyket

blast_results_tab_$(partner)_file = $(blast_seqs_dir)/blast_results.parsed.$(partner).9f

$(blast_results_tab_clf_file):
	mkdir -p $(blast_seqs_dir)
	cat $(parse_blast_dir)/CLF* > $@

$(blast_results_tab_ks_file):
	mkdir -p $(blast_seqs_dir)
	cat $(parse_blast_dir)/KS* > $@

$(blast_results_tab_acp_file):
	mkdir -p $(blast_seqs_dir)
	cat $(parse_blast_dir)/ACP* > $@

$(blast_results_tab_kr_file):
	mkdir -p $(blast_seqs_dir)
	cat $(parse_blast_dir)/KR* > $@

$(blast_results_tab_at_file):
	mkdir -p $(blast_seqs_dir)
	cat $(parse_blast_dir)/AT* > $@

$(blast_results_tab_$(partner)_file):
	mkdir -p $(blast_seqs_dir)
	cat $(parse_blast_dir)/$(partner)* > $@

$(blast_results_tab_ksiii_file):
	mkdir -p $(blast_seqs_dir)
	cat $(parse_blast_dir)/KSIII* > $@


concat: $(blast_results_tab_clf_file) $(blast_results_tab_ks_file) \
	$(blast_results_tab_acp_file) $(blast_results_tab_kr_file) \
	$(blast_results_tab_at_file) $(blast_results_tab_$(partner)_file) \
	$(blast_results_tab_ksiii_file)


#################################################################
# Get (nucleotide) genbank IDs from blast results

$(blast_seqs_dir)/gbs.KS.1f: $(blast_results_tab_ks_file)
	cat $^ \
	| cut -f 1 \
	| sort -u \
	> $@; \

$(blast_seqs_dir)/gbs.CLF.1f: $(blast_results_tab_clf_file)
	cat $^ \
	| cut -f 1 \
	| sort -u \
	> $@

$(blast_seqs_dir)/gbs.ACP.1f: $(blast_results_tab_acp_file)
	cat $^ \
	| cut -f 1 \
	| sort -u \
	> $@

$(blast_seqs_dir)/gbs.KR.1f: $(blast_results_tab_kr_file)
	cat $^ \
        | cut -f 1 \
        | sort -u \
        > $@; \

$(blast_seqs_dir)/gbs.AT.1f: $(blast_results_tab_at_file)
	cat $^ \
        | cut -f 1 \
        | sort -u \
        > $@

$(blast_seqs_dir)/gbs.KSIII.1f: $(blast_results_tab_ksiii_file)
	cat $^ \
        | cut -f 1 \
        | sort -u \
        > $@


$(blast_seqs_dir)/gbs.$(partner).1f: $(blast_results_tab_$(partner)_file)
	cat $^ \
        | cut -f 1 \
        | sort -u \
        > $@


# Get nucleotide genbank IDs that had a match in both KS and ACP  blast hits, and KS and CLF blast hits

$(blast_seqs_dir)/gbs.KSACP.1f: $(blast_seqs_dir)/gbs.KS.1f  $(blast_seqs_dir)/gbs.ACP.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0 -j 0 -o v $^ $@

$(blast_seqs_dir)/gbs.KSCLF.1f: $(blast_seqs_dir)/gbs.KS.1f  $(blast_seqs_dir)/gbs.CLF.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0 -j 0 -o v $^ $@

$(blast_seqs_dir)/gbs.KSKR.1f: $(blast_seqs_dir)/gbs.KS.1f  $(blast_seqs_dir)/gbs.KR.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0 -j 0 -o v $^ $@

$(blast_seqs_dir)/gbs.KSAT.1f: $(blast_seqs_dir)/gbs.KS.1f  $(blast_seqs_dir)/gbs.AT.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0 -j 0 -o v $^ $@

$(blast_seqs_dir)/gbs.KS$(partner).1f: $(blast_seqs_dir)/gbs.KS.1f  $(blast_seqs_dir)/gbs.$(partner).1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0 -j 0 -o v $^ $@

$(blast_seqs_dir)/gbs.KSKSIII.1f: $(blast_seqs_dir)/gbs.KS.1f  $(blast_seqs_dir)/gbs.KSIII.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0 -j 0 -o v $^ $@


# Get nucleotide genbank IDs that had a match in both KS and ACP/KR/AT/Cyclase
nuc_ids: $(blast_seqs_dir)/gbs.KS.1f $(blast_seqs_dir)/gbs.CLF.1f $(blast_seqs_dir)/gbs.KSCLF.1f \
	 $(blast_seqs_dir)/gbs.KS.1f $(blast_seqs_dir)/gbs.ACP.1f $(blast_seqs_dir)/gbs.KSACP.1f \
         $(blast_seqs_dir)/gbs.KS.1f $(blast_seqs_dir)/gbs.KR.1f $(blast_seqs_dir)/gbs.KSKR.1f \
	 $(blast_seqs_dir)/gbs.KS.1f $(blast_seqs_dir)/gbs.AT.1f $(blast_seqs_dir)/gbs.KSAT.1f \
	 $(blast_seqs_dir)/gbs.KS.1f $(blast_seqs_dir)/gbs.$(partner).1f $(blast_seqs_dir)/gbs.KS$(partner).1f \
	 $(blast_seqs_dir)/gbs.KS.1f $(blast_seqs_dir)/gbs.KSIII.1f $(blast_seqs_dir)/gbs.KSKSIII.1f

# Get KS and CLF proteins that exist in gbs.KSCLF.1f
# Get KS and ACP proteins that exist in gbs.KSACP.1f

blast_results_tab_ks_file_match_ksclf = $(blast_results_tab_ks_file).match.ksclf
blast_results_tab_clf_file_match_ksclf = $(blast_results_tab_clf_file).match.ksclf

blast_results_tab_ks_file_match_ksacp = $(blast_results_tab_ks_file).match.ksacp
blast_results_tab_acp_file_match_ksacp = $(blast_results_tab_acp_file).match.ksacp


blast_results_tab_ks_file_match_kskr = $(blast_results_tab_ks_file).match.kskr
blast_results_tab_kr_file_match_kskr = $(blast_results_tab_kr_file).match.kskr

blast_results_tab_ks_file_match_ksat = $(blast_results_tab_ks_file).match.ksat
blast_results_tab_at_file_match_ksat = $(blast_results_tab_at_file).match.ksat

blast_results_tab_ks_file_match_ks$(partner) = $(blast_results_tab_ks_file).match.ks$(partner)
blast_results_tab_$(partner)_file_match_ks$(partner) = $(blast_results_tab_$(partner)_file).match.ks$(partner)

blast_results_tab_ks_file_match_ksksiii = $(blast_results_tab_ks_file).match.ksksiii
blast_results_tab_ksiii_file_match_ksksiii = $(blast_results_tab_ksiii_file).match.ksiii


$(blast_results_tab_ks_file_match_ksclf): $(blast_results_tab_ks_file) $(blast_seqs_dir)/gbs.KSCLF.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@
$(blast_results_tab_clf_file_match_ksclf): $(blast_results_tab_clf_file) $(blast_seqs_dir)/gbs.KSCLF.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@

$(blast_results_tab_ks_file_match_ksacp): $(blast_results_tab_ks_file) $(blast_seqs_dir)/gbs.KSACP.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@
$(blast_results_tab_acp_file_match_ksacp): $(blast_results_tab_acp_file) $(blast_seqs_dir)/gbs.KSACP.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@


$(blast_results_tab_ks_file_match_kskr): $(blast_results_tab_ks_file) $(blast_seqs_dir)/gbs.KSKR.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@
$(blast_results_tab_kr_file_match_kskr): $(blast_results_tab_kr_file) $(blast_seqs_dir)/gbs.KSKR.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@

$(blast_results_tab_ks_file_match_ksat): $(blast_results_tab_ks_file) $(blast_seqs_dir)/gbs.KSAT.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@
$(blast_results_tab_at_file_match_ksat): $(blast_results_tab_at_file) $(blast_seqs_dir)/gbs.KSAT.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@

$(blast_results_tab_ks_file_match_ks$(partner)): $(blast_results_tab_ks_file) $(blast_seqs_dir)/gbs.KS$(partner).1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@
$(blast_results_tab_$(partner)_file_match_ks$(partner)): $(blast_results_tab_$(partner)_file) $(blast_seqs_dir)/gbs.KS$(partner).1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@

$(blast_results_tab_ks_file_match_ksksiii): $(blast_results_tab_ks_file) $(blast_seqs_dir)/gbs.KSKSIII.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@
$(blast_results_tab_ksiii_file_match_ksksiii): $(blast_results_tab_ksiii_file) $(blast_seqs_dir)/gbs.KSKSIII.1f
	perl $(script_dir)/hashjoin.pl -k 0 -v 0-8 -j 0 -o v $^ $@



ksclf_prots:	$(blast_results_tab_ks_file_match_ksclf) $(blast_results_tab_clf_file_match_ksclf) \
		$(blast_results_tab_ks_file_match_ksacp) $(blast_results_tab_acp_file_match_ksacp) \
		$(blast_results_tab_ks_file_match_kskr) $(blast_results_tab_kr_file_match_kskr) \
		$(blast_results_tab_ks_file_match_ksat) $(blast_results_tab_at_file_match_ksat) \
		$(blast_results_tab_ks_file_match_ks$(partner)) $(blast_results_tab_$(partner)_file_match_ks$(partner)) \
		$(blast_results_tab_ks_file_match_ksksiii) $(blast_results_tab_ksiii_file_match_ksksiii) \ 
		$(blast_results_tab_ks_file_match_ksclf) $(blast_results_tab_clf_file_match_ksclf)

#################################################################
# Uniqify the proteins
# eliminiate 100% identical proteins here at this step.
# Choose longest nucleotide synonym.
# Also prioritize the Erin set of nucleotide IDs:  Ie if this protein exists in multiple nucleotide records, one of which is Erin's nucleotide, then keep the Erin nucleotide, not the other one.
# Mark synonyms in a separate file
# filename.synonyms
# length column is 6 (starting from 0) and seq col is 9
# * NOTE this script also removes dashes and asterisks

$(blast_results_tab_clf_file).ksclf.longest_synonym: $(blast_results_tab_clf_file_match_ksclf)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_clf_file).ksclf.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@
$(blast_results_tab_ks_file).ksclf.longest_synonym: $(blast_results_tab_ks_file_match_ksclf)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_ks_file).ksclf.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@


$(blast_results_tab_acp_file).ksacp.longest_synonym: $(blast_results_tab_acp_file_match_ksacp)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_acp_file).ksacp.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@
$(blast_results_tab_ks_file).ksacp.longest_synonym: $(blast_results_tab_ks_file_match_ksacp)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_ks_file).ksacp.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@


$(blast_results_tab_ks_file).kskr.longest_synonym: $(blast_results_tab_ks_file_match_kskr)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_ks_file).kskr.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@
$(blast_results_tab_kr_file).kskr.longest_synonym: $(blast_results_tab_kr_file_match_kskr)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_kr_file).kskr.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@


$(blast_results_tab_ks_file).ksat.longest_synonym: $(blast_results_tab_ks_file_match_ksat)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_ks_file).ksat.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@
$(blast_results_tab_at_file).ksat.longest_synonym: $(blast_results_tab_at_file_match_ksat)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_at_file).ksat.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@


$(blast_results_tab_ks_file).ks$(partner).longest_synonym: $(blast_results_tab_ks_file_match_ks$(partner))
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_ks_file).ks$(partner).synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@
$(blast_results_tab_$(partner)_file).ks$(partner).longest_synonym: $(blast_results_tab_$(partner)_file_match_ks$(partner))
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_$(partner)_file).ks$(partner).synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@


$(blast_results_tab_ks_file).ksksiii.longest_synonym: $(blast_results_tab_ks_file_match_ksksiii)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_ks_file).ksksiii.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@
$(blast_results_tab_ksiii_file).ksksiii.longest_synonym: $(blast_results_tab_ksiii_file_match_ksksiii)
	perl $(script_dir)/chooseLongestSeqSynonym.pl $^ 6 8 $(blast_results_tab_ksiii_file).ksksiii.synonyms Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb > $@


longest: $(blast_results_tab_clf_file).ksclf.longest_synonym $(blast_results_tab_ks_file).ksclf.longest_synonym \
	 $(blast_results_tab_acp_file).ksacp.longest_synonym $(blast_results_tab_ks_file).ksacp.longest_synonym \
         $(blast_results_tab_kr_file).kskr.longest_synonym $(blast_results_tab_ks_file).kskr.longest_synonym \
	 $(blast_results_tab_at_file).ksat.longest_synonym $(blast_results_tab_ks_file).ksat.longest_synonym \
	 $(blast_results_tab_$(partner)_file).ks$(partner).longest_synonym $(blast_results_tab_ks_file).ks$(partner).longest_synonym \
	 $(blast_results_tab_ksiii_file).ksksiii.longest_synonym $(blast_results_tab_ks_file).ksksiii.longest_synonym



# Compare the Erin set to the found set - found them all?

$(blast_results_tab_clf_file).ksclf.longest_synonym.compareErin: $(blast_results_tab_clf_file).ksclf.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@
$(blast_results_tab_ks_file).ksclf.longest_synonym.compareErin: $(blast_results_tab_ks_file).ksclf.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@

$(blast_results_tab_acp_file).ksacp.longest_synonym.compareErin: $(blast_results_tab_acp_file).ksacp.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@
$(blast_results_tab_ks_file).ksacp.longest_synonym.compareErin: $(blast_results_tab_ks_file).ksacp.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@


$(blast_results_tab_kr_file).kskr.longest_synonym.compareErin: $(blast_results_tab_kr_file).kskr.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@
$(blast_results_tab_ks_file).kskr.longest_synonym.compareErin: $(blast_results_tab_ks_file).kskr.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@

$(blast_results_tab_at_file).ksat.longest_synonym.compareErin: $(blast_results_tab_at_file).ksat.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@
$(blast_results_tab_ks_file).ksat.longest_synonym.compareErin: $(blast_results_tab_ks_file).ksat.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@

$(blast_results_tab_$(partner)_file).ks$(partner).longest_synonym.compareErin: $(blast_results_tab_$(partner)_file).ks$(partner).longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@
$(blast_results_tab_ks_file).ks$(partner).longest_synonym.compareErin: $(blast_results_tab_ks_file).ks$(partner).longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@


$(blast_results_tab_ksiii_file).ksksiii.longest_synonym.compareErin: $(blast_results_tab_ksiii_file).ksksiii.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@
$(blast_results_tab_ks_file).ksksiii.longest_synonym.compareErin: $(blast_results_tab_ks_file).ksksiii.longest_synonym Erin/Manual/t2clf.antismash.Erin.gb.names.78.gb
	perl $(script_dir)/compareErin.pl $^ > $@


compare: $(blast_results_tab_clf_file).ksclf.longest_synonym.compareErin \
	 $(blast_results_tab_ks_file).ksclf.longest_synonym.compareErin \
	 $(blast_results_tab_acp_file).ksacp.longest_synonym.compareErin \
	 $(blast_results_tab_ks_file).ksacp.longest_synonym.compareErin \
	 $(blast_results_tab_kr_file).kskr.longest_synonym.compareErin \
	 $(blast_results_tab_ks_file).kskr.longest_synonym.compareErin \
	 $(blast_results_tab_at_file).ksat.longest_synonym.compareErin \
	 $(blast_results_tab_ks_file).ksat.longest_synonym.compareErin \
	 $(blast_results_tab_$(partner)_file).ks$(partner).longest_synonym.compareErin \
	 $(blast_results_tab_ks_file).ks$(partner).longest_synonym.compareErin \
	 $(blast_results_tab_ksiii_file).ksksiii.longest_synonym.compareErin \
	 $(blast_results_tab_ks_file).ksksiii.longest_synonym.compareErin

#################################################################
# Make fasta file of blast hit sequences to use in HMM search (without using min cluster size)

blast_clf_ksclf_fasta = $(blast_seqs_dir)/blast_results.CLF.ksclf.fasta
blast_ks_ksclf_fasta = $(blast_seqs_dir)/blast_results.KS.ksclf.fasta

blast_acp_ksacp_fasta = $(blast_seqs_dir)/blast_results.ACP.ksacp.fasta
blast_ks_ksacp_fasta = $(blast_seqs_dir)/blast_results.KS.ksacp.fasta

blast_kr_kskr_fasta = $(blast_seqs_dir)/blast_results.KR.kskr.fasta
blast_ks_kskr_fasta = $(blast_seqs_dir)/blast_results.KS.kskr.fasta

blast_at_ksat_fasta = $(blast_seqs_dir)/blast_results.AT.ksat.fasta
blast_ks_ksat_fasta = $(blast_seqs_dir)/blast_results.KS.ksat.fasta

blast_$(partner)_ks$(partner)_fasta = $(blast_seqs_dir)/blast_results.$(partner).ks$(partner).fasta
blast_ks_ks$(partner)_fasta = $(blast_seqs_dir)/blast_results.KS.ks$(partner).fasta

blast_ksiii_ksksiii_fasta = $(blast_seqs_dir)/blast_results.KSIII.ksksiii.fasta
blast_ks_ksksiii_fasta = $(blast_seqs_dir)/blast_results.KS.ksksiii.fasta


$(blast_clf_ksclf_fasta): $(blast_results_tab_clf_file).ksclf.longest_synonym
	cat $^ \
	| $(script_dir)/multistab2fasta.pl $^ > $@
$(blast_ks_ksclf_fasta): $(blast_results_tab_ks_file).ksclf.longest_synonym
	cat $^ \
	| $(script_dir)/multistab2fasta.pl $^ > $@

$(blast_acp_ksacp_fasta): $(blast_results_tab_acp_file).ksacp.longest_synonym
	cat $^ \
	| $(script_dir)/multistab2fasta.pl $^ > $@
$(blast_ks_ksacp_fasta): $(blast_results_tab_ks_file).ksacp.longest_synonym
	cat $^ \
	| $(script_dir)/multistab2fasta.pl $^ > $@

$(blast_kr_kskr_fasta): $(blast_results_tab_kr_file).kskr.longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@
$(blast_ks_kskr_fasta): $(blast_results_tab_ks_file).kskr.longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

$(blast_at_ksat_fasta): $(blast_results_tab_at_file).ksat.longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@
$(blast_ks_ksat_fasta): $(blast_results_tab_ks_file).ksat.longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

$(blast_$(partner)_ks$(partner)_fasta): $(blast_results_tab_$(partner)_file).ks$(partner).longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@
$(blast_ks_ks$(partner)_fasta): $(blast_results_tab_ks_file).ks$(partner).longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@

$(blast_ksiii_ksksiii_fasta): $(blast_results_tab_ksiii_file).ksksiii.longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@
$(blast_ks_ksksiii_fasta): $(blast_results_tab_ks_file).ksksiii.longest_synonym
	cat $^ \
        | $(script_dir)/multistab2fasta.pl $^ > $@




# Clean the name - remove illegal chars that cause mafft and fasttree to fail (and hmmer?)

desclen2 = 200
blast_clf_ksclf_fasta_cleanname = $(blast_clf_ksclf_fasta).cleanName
blast_ks_ksclf_fasta_cleanname = $(blast_ks_ksclf_fasta).cleanName

blast_acp_ksacp_fasta_cleanname = $(blast_acp_ksacp_fasta).cleanName
blast_ks_ksacp_fasta_cleanname = $(blast_ks_ksacp_fasta).cleanName

blast_kr_kskr_fasta_cleanname = $(blast_kr_kskr_fasta).cleanName
blast_ks_kskr_fasta_cleanname = $(blast_ks_kskr_fasta).cleanName

blast_at_ksat_fasta_cleanname = $(blast_at_ksat_fasta).cleanName
blast_ks_ksat_fasta_cleanname = $(blast_ks_ksat_fasta).cleanName

blast_$(partner)_ks$(partner)_fasta_cleanname = $(blast_$(partner)_ks$(partner)_fasta).cleanName
blast_ks_ks$(partner)_fasta_cleanname = $(blast_ks_ks$(partner)_fasta).cleanName

blast_ksiii_ksksiii_fasta_cleanname = $(blast_ksiii_ksksiii_fasta).cleanName
blast_ks_ksksiii_fasta_cleanname = $(blast_ks_ksksiii_fasta).cleanName



$(blast_clf_ksclf_fasta_cleanname): $(blast_clf_ksclf_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@
$(blast_ks_ksclf_fasta_cleanname): $(blast_ks_ksclf_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@

$(blast_acp_ksacp_fasta_cleanname): $(blast_acp_ksacp_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@
$(blast_ks_ksacp_fasta_cleanname): $(blast_ks_ksacp_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@

$(blast_kr_kskr_fasta_cleanname): $(blast_kr_kskr_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@
$(blast_ks_kskr_fasta_cleanname): $(blast_ks_kskr_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@

$(blast_at_ksat_fasta_cleanname): $(blast_at_ksat_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@
$(blast_ks_ksat_fasta_cleanname): $(blast_ks_ksat_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@

$(blast_$(partner)_ks$(partner)_fasta_cleanname): $(blast_$(partner)_ks$(partner)_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@
$(blast_ks_ks$(partner)_fasta_cleanname): $(blast_ks_ks$(partner)_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@

$(blast_ksiii_ksksiii_fasta_cleanname): $(blast_ksiii_ksksiii_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@
$(blast_ks_ksksiii_fasta_cleanname): $(blast_ks_ksksiii_fasta)
	perl $(script_dir)/cleanName.pl $^ $(desclen2) > $@


#fasta: $(blast_clf_ksclf_fasta_cleanname) $(blast_ks_ksclf_fasta_cleanname) $(blast_acp_ksacp_fasta_cleanname) $(blast_ks_ksacp_fasta_cleanname)

fasta:  $(blast_clf_ksclf_fasta_cleanname) $(blast_ks_ksclf_fasta_cleanname) \
 	$(blast_acp_ksacp_fasta_cleanname) $(blast_ks_ksacp_fasta_cleanname) \
        $(blast_kr_kskr_fasta_cleanname) $(blast_ks_kskr_fasta_cleanname) \
        $(blast_at_ksat_fasta_cleanname) $(blast_ks_ksat_fasta_cleanname) \
        $(blast_$(partner)_ks$(partner)_fasta_cleanname) $(blast_ks_ks$(partner)_fasta_cleanname) \
        $(blast_ksiii_ksksiii_fasta_cleanname) $(blast_ks_ksksiii_fasta_cleanname)	

clean_fasta: 
	rm -f $(blast_clf_fasta_cleanname) $(blast_ks_fasta_cleanname)
	rm -f $(blast_clf_fasta) $(blast_ks_fasta)


########################################################################################
# GV 031615 Eliminate identical KS/CLFs/ACPs from this set

cdhit_cutoff = .99
cdhit_bin = ~maureenh/Cdhit/cd-hit-v4.6.1-2012-08-27/cd-hit
name_length = 200

$(blast_clf_ksclf_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_clf_ksclf_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)
$(blast_ks_ksclf_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_ks_ksclf_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(blast_acp_ksacp_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_acp_ksacp_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)
$(blast_ks_ksacp_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_ks_ksacp_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(blast_kr_kskr_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_kr_kskr_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)
$(blast_ks_kskr_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_ks_kskr_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(blast_at_ksat_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_at_ksat_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)
$(blast_ks_ksat_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_ks_ksat_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(blast_$(partner)_ks$(partner)_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_$(partner)_ks$(partner)_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)
$(blast_ks_ks$(partner)_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_ks_ks$(partner)_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)

$(blast_ksiii_ksksiii_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_ksiii_ksksiii_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)
$(blast_ks_ksksiii_fasta).cleanName.cdhit$(cdhit_cutoff): $(blast_ks_ksksiii_fasta).cleanName
	$(cdhit_bin) -i $^ -o $@ -c $(cdhit_cutoff) -d $(name_length)


cdhit: $(blast_clf_ksclf_fasta).cleanName.cdhit$(cdhit_cutoff) $(blast_ks_ksclf_fasta).cleanName.cdhit$(cdhit_cutoff) \
       $(blast_acp_ksacp_fasta).cleanName.cdhit$(cdhit_cutoff) $(blast_ks_ksacp_fasta).cleanName.cdhit$(cdhit_cutoff) \
       $(blast_kr_kskr_fasta).cleanName.cdhit$(cdhit_cutoff) $(blast_ks_kskr_fasta).cleanName.cdhit$(cdhit_cutoff) \
       $(blast_at_ksat_fasta).cleanName.cdhit$(cdhit_cutoff) $(blast_ks_ksat_fasta).cleanName.cdhit$(cdhit_cutoff) \
       $(blast_$(partner)_ks$(partner)_fasta).cleanName.cdhit$(cdhit_cutoff) $(blast_ks_ks$(partner)_fasta).cleanName.cdhit$(cdhit_cutoff) \
       $(blast_ksiii_ksksiii_fasta).cleanName.cdhit$(cdhit_cutoff) $(blast_ks_ksksiii_fasta).cleanName.cdhit$(cdhit_cutoff)   

all: cdhit compare                                                                                                       
