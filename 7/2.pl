#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));
use List::Util qw(reduce);

my $line = <>;
$line =~ s/S/1/;
my @previous = split //, $line;

while (<>,my $line = <>) { # skip useless lines
    $line =~ s/\./0/g;
    my @current = split //, $line;

    for(my $i = 0; $i < @previous; $i++) {
        if ($previous[$i] =~ /(\d+)/){
            my $n=$1;
            if( $current[$i] eq '^') {
                $current[$i-1]+= $n;
                $current[$i+1]+= $n;
            } else {
                $current[$i] += $n;
            }
        }
    }
    print join(',', @current);
    @previous = @current;
}

print reduce { $a + $b } grep {/\d+/} @previous;
print "\n";
