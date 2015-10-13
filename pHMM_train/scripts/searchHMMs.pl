#!/usr/bin/perl -w
# Run hmmsearch on a set of sequences
use strict;

#die "Usage: $0 posfile outdir hmmfiles\n" unless @ARGV >= 3;
die "Usage: $0 hmmDir fastaDirToSearch outdir\n" unless @ARGV >= 3;

#my $outdir = shift;
#my $infile = shift;# input fasta file: TODO take a directory instead
#my(@hmmfiles) = @ARGV;

my $hmmdir = shift;
my $fastadir = shift;
my $outdir = shift;

my(@hmmfiles) = `ls $hmmdir`;
chomp(@hmmfiles);
my(@fastafiles) = `ls $fastadir`;
chomp(@fastafiles);

unless(-e $outdir) { `mkdir $outdir`;}

foreach my $hmmfile(@hmmfiles) {
  my $filename = $hmmfile;
  if($hmmfile =~ /\/(.*)/) {
    $filename = $1;
  }
  
  my $outfile = "$outdir/$filename";
  open(OUT, ">$outfile") || die "Can't open $outfile\n";

  foreach my $fastafile(@fastafiles) {
    warn "Running hmmsearch of $hmmfile against $fastafile\n";
    my $cmd = "hmmsearch $hmmdir/$hmmfile $fastadir/$fastafile";
    my $result = `$cmd`;
    print OUT $result;
  }
}

warn "output to $outdir\n\n";
