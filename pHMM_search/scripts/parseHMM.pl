#!/usr/bin/perl -w
#
# Parse hmmsearch results into a tab-delimited output file
#  with sequence ID, information about the location of the hit, and the sequence itself.
# 
# Output line:
#       print "$hitname\t$hitdesc\t$frame\t$strand\t$start\t$end\t$hitlen\t$evalue\t$score\t$hitseq\n";
#
use strict;
use Bio::SearchIO;
use List::Util qw(min max);

die "Usage: $0 infile\n" unless @ARGV >= 1;

my $infile = shift @ARGV;

my $in = new Bio::SearchIO(-format => 'hmmer', 
                           -file   => $infile);

warn "Iterating hmmer results...\n";

warn "Reading first hmmer results...\n";
while( my $result = $in->next_result ) {

  warn "Done reading first hmmer results, iterating hits...\n";
  while( my $hit = $result->next_hit ) {

    my $hitname = $hit->name;
    my $hitdesc = $hit->description;

    my $hitlen = $hit->length;
    my @hsps = $hit->hsps;

    my $hspXNum = 0;
    foreach my $hsp(@hsps) {
      my $frame = $hsp->hit->frame;
      my $strand= $hsp->strand('hit');
      my $start = $hsp->start('hit');
      my $end = $hsp->end('hit');
      my $len = $end - $start;

      # Aug 2014
      my $hitseq= $hsp->hit_string; ############## NOTE: this is the HMM consensus seq! Don't grab this
      my $queryseq= $hsp->query_string;
      my $evalue = $hsp->evalue;
      my $score= $hsp->score;

     # print "$hitname\t$hitdesc\t$frame\t$strand\t$start\t$end\t$hitlen\t$evalue\t$score\t$queryseq\n";
      print "$hitname\t$hitdesc\t$frame\t$strand\t$start\t$end\t$hitlen\t$evalue\t$score\t$hitseq\n";

    }
  }
}

#close(OUT);

#} # end iteration of files




exit;



