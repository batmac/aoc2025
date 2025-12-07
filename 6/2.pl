#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));
use List::Util qw(reduce);

my $total;
my @digits;
my @numbers;
my @ops;
my $max;

## Parsing
while (my $line = <>) {
    chomp $line;
	$max = (length $line > $max) ? length $line : $max;
	my @symbols = split //, $line;
	if ($symbols[0] eq "+" || $symbols[0] eq "*") {
		@symbols = grep { $_ ne ' ' } @symbols;
		@ops = @symbols;
	} else {
		push @digits, [@symbols];
	}
	# print join(", ", @symbols), "\n";
}

# we need to reconstruct the numbers
my @nums;
for (my $i = 0; $i < $max+1; $i++) { # +1 to simulate an empty column at the end
	my $num;
	foreach my $digit (@digits) {
		if (defined $digit->[$i] && $digit->[$i] =~ /\d/) {
			$num .= $digit->[$i];
		} else {
			next;
		}
	}
	if (defined $num) {
		print "found number: $num\n";
		push @nums, int($num);
		undef $num;
	} else {
		# empty column, push the numbers collected
		print("pushing numbers: ", join(", ", @nums), "\n");
		push @numbers, [@nums] if @nums;
		undef @nums;
	}
}

print "numbers:\n";
foreach my $n (@numbers) {
	print join(", ", @$n), "\n";
}

for (my $i = 0; $i < @ops; $i++) {
	my $result;
	my $op = $ops[$i];
	print "operation: $op\n";
	if ($op eq "+") {
		$result=reduce { $a + $b } $numbers[$i]->@*;
	} elsif ($op eq "*") {
		$result=reduce { $a * $b } $numbers[$i]->@*;
	} else {
		die;
	}
	print "result: $result\n";
	$total += $result;
}
print "$total\n";
