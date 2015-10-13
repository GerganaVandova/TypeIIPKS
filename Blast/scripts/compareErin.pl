#!/usr/bin/perl -w
use strict;

use lib "/home/maureenh/lib/";
use MoLib::Misc::MoFunctions;


die "Usage: $0 file1 file2 \n" unless @ARGV >= 2;

my $file1 = shift;
my $file2 = shift;

my %preferred_gb = build_hash_from_list($file2);
warn "Searching for matches in $file1 $file2\n";

foreach my $key (sort keys %preferred_gb) {
  #my $keytest = "$key"."0";
  #my $result = `grep $keytest $file1 | wc`;
  my $result = `grep $key $file1`;
  chomp $result;
  #if($result) {print "$key\t$result\n";}
  if($result) {print "$key\n";}
}




