#!/usr/bin/env perl

use v5.40;
use utf8;
use open qw(:std :encoding(UTF-8));
use Data::Dumper;

my $total = 0;

sub index_du_max(@n) {
	my ($max, $idx) = ($n[0], 0);

    for my $i (1 .. $#n) {
        ($max, $idx) = ($n[$i], $i) if $n[$i] > $max;
    }
	return $idx;
}

while (my $line = <>) {
	chomp $line;
	my @numbers = split //, $line;

	my $imax = index_du_max(@numbers[0 .. $#numbers-1]);
	my $max = $numbers[$imax];

	splice(@numbers, 0, $imax+1);
	my $deuxieme = $numbers[index_du_max(@numbers)];

	$total +=10*$max+$deuxieme
}
print "Total: $total\n";
