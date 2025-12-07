#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));

my $total;
my @numbers;
my @ops;

## Parsing
while (my $line = <>) {
    chomp $line;
	$line=~s/^\s+|\s+$//g;
	my @symbols = split /\s+/, $line;
	if ($symbols[0] eq "+" || $symbols[0] eq "*") {
		@ops = @symbols;
	} else {
		push @numbers, [@symbols];
	}
	# print join(", ", @symbols), "\n";
}

foreach my $op (@ops) {
	my $result;
	print "operation: $op\n";
	if ($op eq "+") {
		$result = 0;
		foreach my $numbers (@numbers) {
			my $n =shift @$numbers;
			print("adding $n\n");
			$result += $n;
		}

	} elsif ($op eq "*") {
		$result = 1;
		foreach my $numbers (@numbers) {
			my $n =shift @$numbers;
			print("multiplying $n\n");
			$result *= $n;
		}
	} else {
		die ;
	}
	print "result: $result\n";
	$total += $result;
}
print "$total\n";
