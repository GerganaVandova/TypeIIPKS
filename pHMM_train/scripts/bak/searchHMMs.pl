#!/usr/bin/perl -w
# Run hmmsearch on a set of sequences
use strict;

die "Usage: $0 posfile outdir hmmfiles\n" unless @ARGV >= 3;

my $outdir = shift;
my $infile = shift;
my(@hmmfiles) = @ARGV;

unless(-e $outdir) { `mkdir $outdir`;}

foreach my $hmmfile(@hmmfiles) {
  my $filename = $hmmfile;
  if($hmmfile =~ /\/(.*)/) {
    $filename = $1;
  }
  
  my $outfile = "$outdir/$filename";
  open(OUT, ">$outfile") || die "Can't open $outfile\n";

  warn "searching $hmmfile against $infile\n";
  my $cmd = "hmmsearch $hmmfile $infile";
  my $result = `$cmd`;

  print OUT $result;
}

warn "output to $outdir\n\n";
