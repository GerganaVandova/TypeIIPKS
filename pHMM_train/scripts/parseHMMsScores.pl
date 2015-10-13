#!/usr/bin/perl -w
#
# Parse hmmsearch results for R
#
use strict;
use Bio::SearchIO;
use List::Util qw(min max);

die "Usage: $0 infile posnegfastafile\n" unless @ARGV >= 3;

my $indir = shift @ARGV;# directory of hmmsearch results, one for each phmm that was queried
#my $fastafile = shift @ARGV;
my $fastadir = shift @ARGV;# directory of fasta files that were searched
my $outdir = shift @ARGV;

unless (-e $outdir) {`mkdir $outdir`;}

my(@fastafilenames) = `ls $fastadir`;
chomp(@fastafilenames);
foreach my $fastafilename(@fastafilenames) {
  my $fastafile = "$fastadir/$fastafilename";

  my $num_seqs_in_fasta = get_num_seqs_in_fasta($fastafile);
  warn "num_seqs_in_fasta = $num_seqs_in_fasta\n";

  my (@infiles) = `ls $indir`;
  chomp(@infiles);

foreach my $infilename(@infiles) {
  my $infile = "$indir/$infilename";
  #my $outfile = "$outdir/$infilename";
  my $outfile = "$outdir/$infilename.$fastafilename";
  warn "outfile = $outfile\n";
  open(OUT, ">$outfile");

  my $count = 0;

  my $in = new Bio::SearchIO(-format => 'hmmer', 
                           -file   => $infile);

  while( my $result = $in->next_result ) {

    # New Mar 5 2015
    my $hmmname = $result->hmm_name();
    my $sequence_file= $result->sequence_file();
    next unless $fastafile eq $sequence_file; ################
    warn "\ninfile = $infile\nhmmname = $hmmname\nsequence_file = $sequence_file\n";
    warn "fastafile = $fastafile\n";
    #next;

    while( my $hit = $result->next_hit ) {
      my $hitname = $hit->name;
      my $hitdesc = $hit->description;
      my $hitlen = $hit->length;
      my @hsps = $hit->hsps;
      my $hspXNum = 0;
      my $best_score = 0; # best score among hsps; not necessarily listed first (like blast)

      foreach my $hsp(@hsps) {
        my $frame = $hsp->hit->frame;
        my $strand= $hsp->strand('hit');
        my $start = $hsp->start('hit');
        my $end = $hsp->end('hit');
        my $len = $end - $start;

        # Aug 2014
        my $hitseq= $hsp->hit_string; ############## NOTE: this is the HMM consensus seq! Don't grab this
        my $queryseq= $hsp->query_string;
        my $evalue = $hsp->evalue;
        my $score= $hsp->score || die "no score for $hitname in $infilename $indir\n";

        if($score > $best_score) {$best_score = $score;}

      } # end iteration of hsps
    print OUT "$best_score\n";
    $count++;
    warn "score = $best_score, $hitname,  count = $count\n";
    
   } # end iteration of  hits
  } # end iteration of results

  my $noResult = $num_seqs_in_fasta- $count;
  warn "noResult = $noResult, num_seqs_in_fasta = $num_seqs_in_fasta\n";
  if ($noResult < 0) {die "Error, less than 0: $noResult\n";}
  if($noResult > 0) {
    for(my $i=0; $i<$noResult; $i++) {
      print OUT "0\n";
    }
  }

  close(OUT);

} # end iteration of hmm hmmsearch files

} # end iteration of fastafiles
warn "output to $outdir\n";


exit;




sub get_num_seqs_in_fasta {
  my $infile = shift;
  my $result = `grep '>' $infile | wc`;
  #print "result = $result\n";
  $result =~ /(\d+)/ || die "Can't count seqs in $infile\n";
  return $1;
}
