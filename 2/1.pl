#!/usr/bin/env perl

use v5.40;
use utf8;
use open qw(:std :encoding(UTF-8));
use Encode qw(decode encode);


my $total = 0;

while (my $line = <>) {
	chomp $line;

	my @intervals = split /,/, $line;
	foreach my $interval (@intervals) {
		my ($start, $end) = split /-/, $interval;
		for (my $i = $start; $i <= $end; $i++) {
			# print "$i\n";
			if ($i =~/^(\d+)\1$/) {
				# print "Has double: $i\n";
				$total+=$i;
				# print "Current total: $total\n";
			}
		}
	}
}
print "Total with doubles: $total\n";
