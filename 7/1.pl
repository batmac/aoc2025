#!/usr/bin/env perl

use v5.40;
# use feature 'signatures';
use utf8;
use open qw(:std :encoding(UTF-8));

my $total;

## Parsing
my @previous;


my $line = <>;
$line =~ s/S/|/;
@previous = split //, $line;

while (my $line = <>) {
    my @current = split //, $line;

    for(my $i = 0; $i < @previous; $i++) {
        if ($previous[$i] eq '|'){
            if( $current[$i] eq '^') {
                $total++;
                $current[$i-1] = '|';
                $current[$i+1]   = '|';
            } else {
                $current[$i]   = '|';
            }
        }
    }
    print join('', @current);
    @previous = @current;

}
print "total: $total\n";
