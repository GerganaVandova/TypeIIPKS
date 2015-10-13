#!/usr/bin/perl
# Maureen's edit of stab2fasta.pl
# sequence is last column; all other cols are joined by underscore as fasta ID

use strict;

my $arg;
while(@ARGV)
{
  $arg = shift @ARGV;

  if($arg eq '--help')
  {
    print STDOUT <DATA>;
    exit(0);
  }
} 

my $name;
my $seq;
my @info;

while(<STDIN>)
{
  chop;
  if(/\S/)
  {
    #($name,$seq) = split("\t");
    (@info) = split("\t");
    $seq = pop @info;
    $name = join("_", @info); ######################################## underscore
    #$name = join(" ", @info); ######################################## space
    print ">$name\n$seq\n";
  }
}

exit(0);

__DATA__

syntax: stab2fasta.pl [OPTIONS] < STAB

STAB is a STAB format file (tab-delimited sequence data) with <name> <seq> on
each line of the file.

