#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));

my $total = 0;
my @grid;

sub print_grid($grid) {
	map { print join('', @$_), "\n" } @$grid;
}

sub count_neighbours($grid, $x, $y) {
	my $count = 0;
	for my $dy (-1..1) {
		for my $dx (-1..1) {
			next if $dx == 0 && $dy == 0;
			my ($neighbour_x, $neighbour_y) = ($x+$dx, $y+$dy);
			if ($neighbour_x >= 0 && $neighbour_y >= 0
				&& $neighbour_y < @$grid && $neighbour_x < $grid->[$neighbour_y]->@*) {
				if ($grid->[$neighbour_y][$neighbour_x] ne '.') {
					$count++;
					# print("($x,$y) has neighbour at ($neighbour_x,$neighbour_y)\n");
				} else {
					# print("($x,$y) has NO neighbour at ($neighbour_x,$neighbour_y)\n");
				}
			}
		}
	}
	return $count;
}


## Parsing
while (my $line = <>) {
	chomp $line;
	push @grid, [ split //, $line ] ;
}
print_grid(\@grid); # initial
print "---\n";
##

while(1) {
	my $subtotal = 0;
	for my $y (0..$#grid) {
		for my $x (0..$grid[$y]->@*-1) {
			if ($grid[$y][$x] ne '.') {
				my $neighbours = count_neighbours(\@grid, $x, $y);
				if ($neighbours < 4) {
					$grid[$y][$x] = '.';
					$subtotal++;
				}
			}
		}
	}
	last if $subtotal == 0; ## no progress
	$total += $subtotal;
}
print_grid(\@grid); # final
print "Total: $total\n";
