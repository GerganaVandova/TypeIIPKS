#!/usr/bin/perl -w
use strict;
use List::Util qw(min max);

die "Usage: $0 ksfile clffile cutoff\n" unless @ARGV >= 3;

my $ksfile = shift;
my $clffile = shift;
my $near_cutoff = shift;
my $totalspan_cutoff = shift;

warn "ksfile = $ksfile, clffile = $clffile, near cutoff = $near_cutoff total span cutoff = $totalspan_cutoff\n";

my %ks; # key = gb, key2 = start, val = end
my %ks_seq; # key = gb, key2 = start, val = seq

# Build KS ids/coords
open(KS, $ksfile);
while(<KS>) {
  chomp;
  my($id, @rest) = split("\t", $_);
  my $seq = pop @rest;
  $id =~ /(.*?)\.(.*)/ || die "$id not properly formatted\n";
  my $gb = $1;
  #print $gb;
  my $info = $2;
  $info =~ /\d+_.*?_(\d+)_(\d+)_/ || die "$id not properly formatted\n";
  my $start = $1;
  my $stop = $2;
  $ks{$gb}{$start} = $stop;
  $ks_seq{$gb}{$start} = $seq;
}


# compare CLF to KS coords
open(CLF, $clffile);
while(<CLF>) {
  chomp;
  my($id, @rest) = split("\t", $_);
  my $clf_seq = pop @rest;

  $id =~ /(.*?)\.(.*)/ || die "$id not properly formatted\n";
  my $gb = $1;
  #print $gb;

  my $info = $2;
  $info =~ /\d+_.*?_(\d+)_(\d+)_/ || die "$id not properly formatted\n";
  my $clf_start = $1;
  my $clf_end = $2;
  my $ks_starts = $ks{$gb};

  my $found_matching_ks = 0;
  my $found_ks_start = 0;
  my $found_ks_end = 0;
  my $ks_seq = "";

  # Check whether KS and CLF are nearby (might be overlapping)
  # There are multiple KS and CLF starts, so check totalspan for each pair
  foreach my $ks_start(sort keys %$ks_starts) {
    my $ks_end = $ks{$gb}{$ks_start} || die "None found for $gb $ks_start\n";
  #  print " ks $ks_start $ks_end clf $clf_start $clf_end \n";
    if( abs($ks_start-$clf_start) < $near_cutoff  ||
	abs($ks_start-$clf_end) < $near_cutoff ||
	abs($ks_end-$clf_start) < $near_cutoff ||
	abs($ks_end-$clf_end) < $near_cutoff
    ) { 

        # New Sep 3
        # Also Check whether KS and CLF span totalspan cutoff
        my $max = max($ks_start, $ks_end, $clf_start, $clf_end);
        my $min = min($ks_start, $ks_end, $clf_start, $clf_end);
        my $totalspan = $max - $min;
        if($totalspan > $totalspan_cutoff) {
          $found_matching_ks = 1;
          $ks_seq = $ks_seq{$gb}{$ks_start} || die "Can't find seq fir $gb $ks_start\n";
          $found_ks_start = $ks_start;
          $found_ks_end= $ks_end;
	  #warn "found $ks_start $ks_end $clf_start $clf_end\n";
        }
    }
  }

  if($found_matching_ks) {
    print "$gb\t$found_ks_start-$found_ks_end\t$ks_seq\t$clf_start-$clf_end\t$clf_seq\n";
  }
}

exit;








