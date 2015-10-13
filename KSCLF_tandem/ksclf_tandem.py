#!/usr/bin/env python
# Blast query genes against nucleotide databases

import os
import subprocess

script_dir = "scripts"

hmm_model_filenames = ("t2ks.selectKnown12.hmm",
                       "t2clf.selectKnown12.hmm",
                       "t2ACP.selectKnown12.hmm",
                       "t2kr.selectKnown16.hmm",
                       "t2at.selectKnown7.hmm",
                       "t2cyclase.selectKnown25.hmm",
                       "t2ksiii.selectKnown10.hmm")

hmm_score_cutoffs = [323, 162, 14, 34, 155, 10, 62]


hmm_filtered_files = []

# Input file, result of hmmsearch in previous step
input_dir = "../pHMM_search"

for i in xrange(0, len(hmm_model_filenames)):
    hmm_filtered_filename = hmm_model_filenames[i] + "." + str(hmm_score_cutoffs[i])
    hmm_filtered_file = os.path.join(input_dir, hmm_filtered_filename)
    hmm_filtered_files.append(hmm_filtered_file)



# Cutoffs to filter KS+CLF and KS+ACP in tandem
near_cutoff = 10000
total_span_cutoff_ks = 1500 # eliminate overlapping KS, KSIII  and CLF hits on same gene
total_span_cutoff = 0 # for all the other domains

hmm_filtered_file_ksclf_nearby = hmm_model_filenames[0] + "." + str(hmm_score_cutoffs[0]) + \
                                "." + hmm_model_filenames[1] + "." + str(hmm_score_cutoffs[1]) + \
                                ".nearby." + str(near_cutoff) + "b.totalSpan." + str(total_span_cutoff_ks)
print hmm_filtered_file_ksclf_nearby


tandem_script = os.path.join(script_dir, "findKSCLFnearbyTotalSpan.pl")
print tandem_script



subprocess.call(["perl", tandem_script, hmm_filtered_file[0], hmm_filtered_file[1], near_cutoff, total_span_cutoff_ks, shell=True])
#subprocess.call("perl scripts/findKSCLFnearbyTotalSpan.pl ../pHMM_search/t2ks.selectKnown12.hmm.hmmsearch.parsed.323 ../pHMM_search/t2clf.selectKnown12.hmm.hmmsearch.parsed.162 10000 1500", shell=True)


"""
hmm_filtered_file_ksclf_nearby = $(hmm_model_filename_ks).$(hmm_score_cutoff_ks).$(hmm_model_filename_clf).$(hmm_score_cutoff_clf).nearby.$(near_cutoff)b.totalSpan.$(total_span_cutoff_ks)
$(hmm_filtered_file_ksclf_nearby): $(hmm_filtered_file_ks) $(hmm_filtered_file_clf)
        perl $(script_dir)/findKSCLFnearbyTotalSpan.pl $^ \
        $(near_cutoff) \
        $(total_span_cutoff_ks) \
        > $@; \











hmm_filtered_file_ksclf = hmm_filtered_file_ksclf_tandem








blast_query_dir = "Manual"

# updated blast databases on 02/20/2015
blastdbdir = "/home/gvandova/blast/db"

# Blast parameters
num_alignments = 100000
blast_evalue_cutoff = 1
# GV not used in this script; added in parse_script
blast_evalue_cutoff_parse = 1
blastoutdir = "blast_results"


subprocess.call(["mkdir", "-p", blastoutdir])

dbs = ["nt", "refseq_genomic", "other_genomic", "env_nt", "patnt", "sts",
       "htgs", "tsa_nt", "wgs", "gss"]


# Blast Cyclases, AT, KR, KSIII domains:
blast_query_names = []


for blast_query_name in blast_query_names:
    for db in dbs:
        dbdir = os.path.join(blastdbdir, db)
        blast_query_file = os.path.join(blast_query_dir, blast_query_name)
        print blast_query_name, db, "\n"
        outfilename = os.path.join(blastoutdir, blast_query_name + "." + str(num_alignments) + ".alignments.evalue" + str(blast_evalue_cutoff) + "." + db)
        print outfilename
        subprocess.call(["tblastn", "-query", blast_query_file, "-db", dbdir, "-out",  outfilename, "-num_alignments", str(num_alignments), "-seg",  "no",  "-evalue", str(blast_evalue_cutoff),  "-num_threads", "58"])


# parse_blast output:
#       print OUT "$hitname\t$start\t$end\t$hitdesc\t$frame\t$strand\t$hitlen\t$evalue\t$hitseq\n";

parse_script = "scripts/getGBHitCoordsFilesInDir.pl"
parse_blast_dir = "blast_results_parse"

subprocess.call(["mkdir", "-p", parse_blast_dir])
subprocess.call(["perl", parse_script, blastoutdir, parse_blast_dir])
"""
