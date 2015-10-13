#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;

die "Usage: $0 file length\n" unless @ARGV >= 2;

my $file = shift @ARGV;
my $newlen = shift @ARGV;


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

    my $shortdesc = "$id"."_$desc";

    $shortdesc = substr($shortdesc, 0, $newlen);
    $shortdesc =~ s/\s/_/g;
    $shortdesc =~ s/\,/_/g;
    $shortdesc =~ s/\(/_/g;
    $shortdesc =~ s/\)/_/g;
    $shortdesc =~ s/\[/_/g;
    $shortdesc =~ s/\]/_/g;
    $shortdesc =~ s/\:/_/g;
    $shortdesc =~ s/\;/_/g;
    $shortdesc =~ s/\\/_/g;
    $shortdesc =~ s/\//_/g;
    $shortdesc =~ s/\'/_/g;
    $shortdesc =~ s/\"/_/g;
    $shortdesc =~ s/\|/_/g;

    $shortdesc =~ s/^ref_//g;
    $shortdesc =~ s/^dbj_//g;
    $shortdesc =~ s/^emb_//g;
    $shortdesc =~ s/^gb_//g;
    $shortdesc =~ s/^tpe_//g;
    $shortdesc =~ s/^tpg_//g;

    $shortdesc =~ s/_$//g;

    print ">$shortdesc\n$seq\n";

}

