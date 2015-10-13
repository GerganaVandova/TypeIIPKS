#!/usr/bin/perl -w
use strict;
use warnings;

die <DATA> unless @ARGV;
my ($outrest, $uniqueval, $oneval, @hashkeyfs, @valuefs, @joinkeyfs, @outfs, $defval) = (0, 0); # default values for the options
while ($ARGV[0] =~ /^-./) {
    my $optname = shift @ARGV;
    if ($optname eq '-k') {
	@hashkeyfs = split(/,/, shift @ARGV);
    } elsif ($optname eq '-v') {
	@valuefs = split(/,/, shift @ARGV);
    } elsif ($optname eq '-j') {
	@joinkeyfs = split(/,/, shift @ARGV);
    } elsif ($optname eq '-o') {
	@outfs = split(/,/, shift @ARGV);
    } elsif ($optname eq '-e') {
	$defval = shift @ARGV;
    } elsif ($optname eq '-r') {
	$outrest = 1;
    } elsif ($optname eq '-u') {
	$uniqueval = 1;
    } else {
	die "Error: invalid options: $optname!";
    }
}
if ($outrest == 1) {
    # When '-r', the default value for 'v' field is '0' if no '-e'
    # This also allows us a way to check whether to output non-matching lines later
    $defval = 0 unless defined($defval);
}
open(HASHFILE, "<$ARGV[0]") or die "Error: can not open $ARGV[0] : $!";
my $hashline = <HASHFILE>; # DO NOT chomp() here because otherwise a '0' may terminate the while loop down there
my $numhashfield = split(/\t/, $hashline, -1);
open(JOINFILE, "<$ARGV[1]") or die "Error: can not open $ARGV[1] : $!";
my $joinline = <JOINFILE>; # DO NOT chomp() here because otherwise a '0' may terminate the while loop down there
my $numjoinfield = split(/\t/, $joinline, -1);
@hashkeyfs = map {
    my @t = split(/-/); map { if ($_ =~ s{^L}{}) { $_ = $numhashfield - $_ } } @t; @t == 1 ? $t[0] : $t[0] .. $t[1];
} @hashkeyfs;
@valuefs = map {
    my @t = split(/-/); map { if ($_ =~ s{^L}{}) { $_ = $numhashfield - $_ } } @t; @t == 1 ? $t[0] : $t[0] .. $t[1];
} @valuefs;
@joinkeyfs = map {
    my @t = split(/-/); map { if ($_ =~ s{^L}{}) { $_ = $numjoinfield - $_ } } @t; @t == 1 ? $t[0] : $t[0] .. $t[1];
} @joinkeyfs;
@outfs = map {
    my @t = split(/-/); map { if ($_ =~ s{^L}{}) { $_ = $numjoinfield - $_ } } @t; @t == 1 ? $t[0] : $t[0] .. $t[1];
} @outfs;
die "Error: # key fields in hash file and join file not the same!" if (scalar(@hashkeyfs) != scalar(@joinkeyfs));
@outfs = map { $_ eq 'v' ? 0 : $_ + 1 } @outfs;

my %hashes = ();
while ($hashline) { # Do this because open and close a file two times would have problem if using standard input
    chomp($hashline);
    my @fields = split(/\t/, $hashline, -1);
    my $key = join("\t", @fields[@hashkeyfs]);
    my $value = join("\t", @fields[@valuefs]);
    if ($uniqueval == 0 or not exists $hashes{$key}) {
	push @{$hashes{$key}}, $value;
    }
} continue {
    $hashline = <HASHFILE>;
}
close(HASHFILE);
die "Error: output file exists: $ARGV[2] !" if (-e "$ARGV[2]");
open(OUTFILE, ">$ARGV[2]") or die "Error: can't open $ARGV[2]: $!";
while ($joinline) {
    chomp($joinline);
    my @fields = split(/\t/, $joinline, -1);
    my $key = join("\t", @fields[@joinkeyfs]);
    my @values = ();
    if (exists $hashes{$key}) {
	next if ($outrest == 1);
	@values = @{$hashes{$key}};
    } else {
	next unless (defined($defval));
	$values[0] = $defval;
    }
    foreach my $value (@values) {
	unshift @fields, $value;
	print OUTFILE join("\t", @fields[@outfs]) . "\n";
	shift @fields;
    }
} continue {
    $joinline = <JOINFILE>;
}
close(OUTFILE);
close(JOINFILE);

__DATA__

Error: Usage: hashjoin.pl [-k <range>(,<range>)*] [-v <range>(,<range>)*] [-j <range>(,<range>)*] [-o v|<range>(,v|<range>)*] [-e <string>] [-r] [-u] <i.tab hash> <i.tab join> <o.tab out>

<range> := <field>[-<field>]
<field> := [L]<num>

Do an efficient join (or key/value conversion) using hash.
Note: field range specification:
  1. all fields numbering start at 0
  2. <field>-<field> is inclusive at both ends
  3. L<num> is the last <num> field. L1 is the last field
    Note: Last field may be different for different options because they may refer to different files

-k: key fields for the file <hash> in key/value pair
Note: the order are used to match the key fields in <join>
Default: no key field. All lines match like doing a big Cartesian product

-v: value fields for the file <hash> in key/value pair
Note:
  for each line in <hash>, create an hash entry with the key/value based on the key fields (-k) and value fields (-v). Orders are preserved as specified in the comma seperated list
  Keys can have multiple values (even same values), all of which will be associated with the key entry
Default: no value field. The value for each key will be empty string

-j: key fields for the file <join> to match the key in <hash>
Note: the order for the key fields in <join> and <hash> has to be the same and they should have same number of fields.

-o: order of output fields
Comma seperated numbers or 'v':
  'v': output all the value fields in the order as specified by -v option.
  number: output the field in the <join>
Note:
  value(s) is decided based on the key and the hash created
  If there are multiple values (even same values) matches the key, multiple lines is outputed

-e: what to output if no key is matched
  Use <string> as the value fields if the join line doesn't match any key
  If no 'v' specified in '-o' option, the line is still outputed according to other fields in '-o' and the string after -e is not used
Default: The line is skipped. Nothing is outputed. See below for default when '-r' is specified

-r: output if no key is matched. Skip those matched lines
  If 'v' is specified in '-o' option, output the string after '-e' in place where 'v' is speficied. Output '0' if no '-e'
Default: Output if key is matched

-u: use the first value for a key, if there are multiple values for the same key.
Default: use all the values for the key

<hash>: fields for creating key/value pair in the hash

<join>: fields with keys to be converted to values based on the hash created.

<out>:
  for each line in <join>, output multiple lines if multiple values match the key with one line for each value. Even if same values appear multiple times, they are outputed multiple times
  Fields are ordered based on -o option
  Output are sorted first based on the order of <join> file. Then for each line in <join> matching multiple values, sort based on the order the value appear in the <hash> file

