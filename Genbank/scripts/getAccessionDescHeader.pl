#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;

die "Usage: $0 genbank_dir \n" unless @ARGV >= 1;
my $genbank_dir = shift;

my(@gbs) = `ls $genbank_dir`;
chomp(@gbs);
foreach my $gb(@gbs) {
  $gb =~ /(.*)\.gb/;
  my $accession = $1 || $gb;
  my ($length) = getDescSimple($gb);
  print "$accession\t$length\n";
  
}
exit;

sub getDescSimple {
  my $gb = shift;
  my $file = "$genbank_dir/$gb";
  unless (-e $file) { die "Error, no file $file\n";}
  my $firstlines = `head -n 30 $file|tail -n 29`; # first 30 lines, excluding first
  $firstlines =~ s/\n//g;
  $firstlines =~ s/\s+/ /g;
  my $def = $firstlines;
  $firstlines =~ /DEFINITION\s+(.*)ACCESSION/ || warn "No def for $gb\n";
  $def = $1 ||"NA";
  return $def;
}





