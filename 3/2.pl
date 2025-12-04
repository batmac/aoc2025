#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));
use Data::Dumper;

use List::Util qw(reduce);

my $total = 0;


sub index_du_max(@n) {
	return reduce { $n[$a] > $n[$b] ? $a : $b } 0 .. $#n;
}

while (my $line = <>) {
	print "line         \t$line";
	chomp $line;
	my @numbers = split //, $line;

	my @digits = ();
	my $lastmaxpos = 0;
	for my $nth (reverse(1 .. 12)) {

		my @candidates = @numbers[$lastmaxpos+1 .. $#numbers-$nth+1];
		print "candidates $nth:\t", " "x$lastmaxpos . join("", @candidates), "\n";
		my $lastrelativemax = index_du_max(@candidates);
		$lastmaxpos += 1+$lastrelativemax;
		push @digits, $numbers[$lastmaxpos];

	}
	print "@digits\n";
	$total += int(join("", @digits));
}
print "Total: $total\n";
