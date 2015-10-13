#!/usr/bin/perl -w
use strict;

use Bio::SeqIO;

die "Usage: $0 fastafile otherfile\n" unless @ARGV >= 4;

my $fastafile = shift;
my $otherfile = shift;
my $col1 = shift;# column that has the genbank id
my $col2 = shift;# column that has the information to be joined to the fasta id

my %gb_info = build_hash_from_cols($otherfile, $col1, $col2);

warn "infile = $fastafile\n";
my $in  = Bio::SeqIO->new(-file => "$fastafile" ,
                           -format => 'FASTA');

# Only print ids once (otherwise R complains about duplicate row.names)
my %seen = ();

while(my $seqobj = $in->next_seq()) {
    if(!$seqobj) {warn "no sequence for $fastafile\n";next;}
    #my $id = $seqobj->accession_number;
    my $id= $seqobj->id;
    #my $desc = $seqobj->desc;

    next if $seen{$id};
    $seen{$id} = 1;

    my($gbstart, $end) = split('-', $id);
    my $gb = $gbstart;
    $gb =~ s/_\d+//g;
    #print "gb = $gb\n";
    my $info = $gb_info{$gb};
    print "$id\t$info\n";
}



sub build_hash_from_cols {
  my($file, $col1, $col2) = @_;
  open(TWOCOL, $file) || warn "Warning:  error opening $file:  $!\n";
  my %hash;
  while(<TWOCOL>) {
    chomp;
    my(@info) = split("\t", $_);
    next unless $info[$col1];
    $hash{$info[$col1]} = $info[$col2];
  }
  return %hash;
}


