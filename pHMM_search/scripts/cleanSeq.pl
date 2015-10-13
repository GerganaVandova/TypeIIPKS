#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;

die "Usage: $0 file length\n" unless @ARGV >= 1;

my $file = shift @ARGV;


my %keep = (); # key = iddesc, val = seq

warn "infile = $file\n";
my $in  = Bio::SeqIO->new(-file => "$file" ,
                           -format => 'FASTA');
                         #  -format => 'fasta');
while(my $seqobj = $in->next_seq()) {
    if(!$seqobj) {warn "no sequence for $file\n";next;}
    #my $id = $seqobj->accession_number;
    my $id= $seqobj->id;
    my $desc = $seqobj->desc;
    my $seq = $seqobj->seq;

    $seq =~ s/-//g;
    $seq =~ s/\*//g;
    $seq = uc($seq);

    print ">$id $desc\n$seq\n";

}

