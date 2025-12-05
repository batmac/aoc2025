#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));

my $total;
my(@starts, @ends);


sub intervals_overlap($start1, $end1, $start2, $end2) {
	my$r = !($end1 < $start2 || $end2 < $start1);
	# print("Checking overlap: $start1-$end1 with $start2-$end2: ", $r ? "OVERLAP\n" : "no overlap\n");
	return $r;
}

sub merge_intervals($start1, $end1, $start2, $end2) {
	my $new_start = $start1 < $start2 ? $start1 : $start2;
	my $new_end = $end1 > $end2 ? $end1 : $end2;
	# print("MERGING intervals: $start1-$end1 with $start2-$end2 to $new_start-$new_end\n");
	return ($new_start, $new_end);
}

## Parsing
while (my $line = <>) {
	if ($line =~ /(\d+)-(\d+)/) {
		push @starts, $1;
		push @ends, $2;
	}
}
print "Intervals: ", $#starts+1, "\n";

my $loop = 0;
try_merge_intervals: {
	$loop++;
	for my $i (0..$#starts-1) {
		# print "Trying to merge interval $i: $starts[$i]-$ends[$i]\n";
		my ($start1, $end1) = ($starts[$i], $ends[$i]);
		for my $j ($i+1..$#starts) {
			my ($start2, $end2) = ($starts[$j], $ends[$j]);
			if (intervals_overlap($start1, $end1, $start2, $end2)) {
				my ($new_start, $new_end) = merge_intervals($start1, $end1, $start2, $end2);
				# $intervals[$i] = "$new_start-$new_end";
				# splice @intervals, $j, 1;
				$starts[$j] = $new_start;
				$ends[$j] = $new_end;
				splice @starts, $i, 1;
				splice @ends, $i, 1;
				redo try_merge_intervals;
			}
		}
	}
}
print "after merges, Intervals: ", $#starts+1, " with $loop loops\n";

map { $total += $ends[$_] - $starts[$_] + 1; } 0..$#starts;
print "Total: $total\n";
