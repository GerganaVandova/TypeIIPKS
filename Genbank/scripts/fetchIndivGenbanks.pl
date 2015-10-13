#!/usr/bin/perl -w
# genbank id types accepted:
# ref, dbj, emb, gb, tpe

use strict;
use Bio::DB::EUtilities;
use Bio::Root::Exception;
use Error qw(:try);
use warnings;


die "Usage: $0 infile seqFormat outDir\n" unless @ARGV >= 3;

my $infile = shift @ARGV;
my $seqFormat= shift @ARGV;
my $outDir = shift @ARGV;
my $start_counter = shift @ARGV || 0;

if(-e $outDir) {warn "Warning $outDir exists, will append into that dir\n";}
else {`mkdir $outDir`;}


my @idsAll = getGenbankIds($infile);
my $numIds = @idsAll;
warn "Num of ids = $numIds\n";

my $counter = 0;
foreach my $id(sort @idsAll) {

  unless ($counter >= $start_counter) {$counter++;next;}
  warn "id = $id\n";
  if($id =~ /no cluster sequenced/) {next;}
  if($id =~ /NCBI sequence accession/) {next;}

  # see if file was already downloaded in this dir
  my $outfile = "$outDir/$id.$seqFormat";
  if($seqFormat eq "gbwithparts") {$outfile = "$outDir/$id.gb";} # use gb instead of gbwithparts as suffix, because antismash doesn't recognize gbwithparts

  if (-e $outfile) {$counter++;next;}

  warn "fetching id = $id\n";

  my $factory = Bio::DB::EUtilities->new(-eutil   => 'efetch',
                                       -db      => 'nucleotide',
                                       -rettype => $seqFormat,
                                       -email   => 'maureenh@stanford.edu',
                                       -id      => $id);

  # dump HTTP::Response content to a file (not retained in memory)
  try {
    $factory->get_Response(-file => $outfile);
    #$factory->get_response(-file => $outfile); # doesn't work? old?
  } catch Bio::Root::Exception with {
       my $err = shift;
       if (! defined $err) {
           warn "MAY HAVE DOWNLOADED $id..\n";
       } else {
               warn "$err\n";
       }
  };

  $counter++;

}
 
exit;



sub getGenbankIds {
  my $file = shift;
  open(IN, $file);
  my %genbankIds = ();
  while(<IN>) {
    chomp;
    my($genbank, @rest) = split("\t", $_);

    if($genbank =~ /(.*\|.*\|).*/) {
      $genbank = $1;
    }

    $genbank =~ s/ref//g;
    $genbank =~ s/dbj//g;
    $genbank =~ s/emb//g;
    $genbank =~ s/gb//g;
    $genbank =~ s/tpe//g;
    $genbank =~ s/tpg//g;
    $genbank =~ s/\|//g;
    $genbankIds{$genbank} = 1;
  }
  close(IN);
  return sort keys %genbankIds;
}

