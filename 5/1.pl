#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));

my $total;
my @ids;
my @intervals;

## Parsing
while (my $line = <>) {
	chomp $line;

	if ($line =~ /(\d+)-(\d+)/) {
		push @intervals, $line
	} elsif ($line =~ /(\d+)/) {
		push @ids, $line;
	}
}

## Processing
foreach my $id (@ids) {
	foreach my $interval (@intervals) {
		if ($interval =~ /(\d+)-(\d+)/) {
			my $start = $1;
			my $end = $2;

			if ($id >= $start && $id <= $end) {
				$total++;
				last;
			}
		} else {
			die "Invalid interval format: $interval\n";
		}
	}
}
# print "intervals: $#intervals     IDs: $#ids\n";

print "Total: $total\n";
