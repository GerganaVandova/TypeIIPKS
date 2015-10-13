#!/usr/bin/perl -w

# See feature annotation in bioperl:
# http://www.bioperl.org/wiki/HOWTO:Feature-Annotation
use strict;
use Bio::SeqIO;


die "Usage: $0 genbankDir level\n" unless @ARGV >= 2;

my $genbankDir = shift @ARGV;
my $level = shift @ARGV;


my @files = `ls $genbankDir`;
chomp(@files);

foreach my $genbank(@files){ 

  my $file = "$genbankDir/$genbank";

  $genbank =~ /(.*)\.gb/;
  my $id = $1;

  my $taxon_string = get_taxon_string($file);

  my(@info) = split(';', $taxon_string);
  my $taxon = $info[$level-1] || warn "No taxon at level $level for $file.  Taxon string = '$taxon_string'\n";

  if($taxon eq "1") {warn "For $file, taxon is 1: '$taxon_string'\n"; $taxon = $info[0];}

  $taxon =~ s/^\s+//g;
  $taxon =~ s/\.//g;

  print "$id\t$taxon\n";


}

exit;


sub get_taxon_string {
  my $file = shift;
  my $in_taxon = 0;
  my $taxon_string = "";
  open(IN, $file);
  while(<IN>) {
    chomp;
    if($_ =~ /ORGANISM/) {
      $in_taxon = 1;
    }
    elsif($_ =~ /^[A-Z]/ && $in_taxon) {# line starts with a letter, not a whitespace in the ORGANISM section
    #elsif($_ =~ /REFERENCE/ || $_ =~ /AUTHORS/ || $_ =~ /COMMENT/ || $_ =~ /ORIGIN/) {
      #$in_taxon = 0;
      return $taxon_string;
    }
    elsif($in_taxon) {
      $taxon_string .= $_;
    }
  }
  #warn "Warning: in get_taxon_string, no taxon for $file\n";
  return 0;
}
  


