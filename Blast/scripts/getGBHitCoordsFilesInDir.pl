#!/usr/bin/perl -w
use strict;
use Bio::SearchIO;
use List::Util qw(min max);

die "Usage: $0 indir outdir\n" unless @ARGV >= 2;

my $indir = shift @ARGV;
my $outdir = shift @ARGV;

my (@infiles) = `ls $indir`;
chomp(@infiles);

foreach my $infilename(@infiles) {

my $infile = "$indir/$infilename";
my $outfile = "$outdir/$infilename.parse";
open(OUT, ">$outfile");

my $in = new Bio::SearchIO(-format => 'blast', 
                           -file   => $infile);

warn "Iterating blast results...\n";
warn "outfile = $outfile\n";

while( my $result = $in->next_result ) {

  while( my $hit = $result->next_hit ) {

    my $hitname = $hit->name;
    my $hitdesc = $hit->description;

    # Look for multiple lines - can cause problems later
   #if($hitdesc =~ /\n/) {die "hitdesc has multiple lines: $hitname $hitdesc\n";}
    if($hitdesc =~ /(.*?)....\|/) {
      $hitdesc = $1;
    }

    #next unless $hitdesc =~ /Toxo/; ####################### debug

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
      my $hitseq= $hsp->hit_string;
      my $evalue = $hsp->evalue;

      #print OUT "$hitname\t$hitdesc\t$frame\t$strand\t$start\t$end\t$hitlen\t$evalue\t$hitseq\n";

    #GV 03/17/2015 added blast_parse_cutoff
    my $blast_evalue_cutoff = 1;
    if ($evalue < $blast_evalue_cutoff) {
      print OUT "$hitname\t$start\t$end\t$hitdesc\t$frame\t$strand\t$hitlen\t$evalue\t$hitseq\n";
      }

    }
  }
}

close(OUT);

} # end iteration of files




exit;



