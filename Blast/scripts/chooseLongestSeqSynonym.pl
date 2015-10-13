#!/usr/bin/perl -w
use strict;
use lib "/home/maureenh/lib/";
use MoLib::Misc::MoFunctions;

die "Usage: $0 infile length_col seq_col synonym_file\n" unless @ARGV >= 5;

my $infile = shift;
my $length_col = shift;
my $seq_col = shift;
my $synonym_file = shift;
my $preferred_file = shift;

my %preferred_gb = build_hash_from_list($preferred_file);

# First build the length info
# Stored in %seq_maxlength
my %seq_maxlength = (); # key = protseq, val = maxlength
my %seq_synonyms = ();
open(IN, $infile);
while(<IN>) {
  chomp;
  my(@info) = split("\t", $_);
  my $seq = $info[$seq_col] || die "No seq for $_\n";
  $seq =~ s/\-//g;
  $seq =~ s/\*//g;
  my $length = $info[$length_col];
  my $genbank = $info[0];
  $seq_synonyms{$seq}{$genbank} = 1;
  my $current_maxlength = $seq_maxlength{$seq} || $length;
  if ($length >= $current_maxlength) {
    $seq_maxlength{$seq} = $length;
  }
}
close(IN);

# Iterate infile again, printing lines that have longest length
my %seenseq;
open(IN2, $infile);
while(<IN2>) {
  chomp;
  my(@info) = split("\t", $_);

  # debug
  #next unless $info[0] =~ /L05390/;
  #warn "info[0] = $info[0]\n";

  my $seq = $info[$seq_col];
  $seq =~ s/\-//g;
  $seq =~ s/\*//g;

  # Special case:  if exists in Erin set, print anyway .  Eg synonyms L05390 and BD129568.1 -- are identical but L05390 is better because has genes annotated and t2clf is found by antismash
  foreach my $gb(keys %preferred_gb) {
    #warn "gb = '$gb'\n";
    if($info[0] =~ /$gb/) {
      $info[$seq_col] = $seq; # replace seq with dashes with clean seq
      #print "$_\n";
      print join("\t", @info), "\n";
    }
  }

  next if $seenseq{$seq};
  my $length = $info[$length_col];
  my $maxlength = $seq_maxlength{$seq} || die "No maxlength found for $seq\n";

  if($length == $maxlength) { # This is the synonym to print
    $info[$seq_col] = $seq; # replace seq with dashes with clean seq
    print join("\t", @info), "\n";
    $seenseq{$info[$seq_col]} = 1;
  }
}


# Print synonyms
open(OUT, ">$synonym_file");
foreach my $seq(keys %seq_synonyms) {
  print OUT "$seq";
  my $synonyms = $seq_synonyms{$seq};
  foreach my $synonym(sort keys %$synonyms) {
    print OUT "\t$synonym";
  }
  print OUT "\n";
}

warn "Other output to $synonym_file\n";
