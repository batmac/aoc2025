
use v5.40;

my $v = 50;
my @l = ();

while (my $line = <>) {
	chomp $line;

    if ($line =~ /([L,R])(\d+)/) {
		my $direction = $1;
		my $steps = $2;
		say "Direction: $direction, Steps: $steps";

		$v += $steps if $direction eq 'R';
		$v -= $steps if $direction eq 'L';
		$v %=100;
		say "Value: $v";
		push @l, $v;
	} else {
		die "No match found on line $.: $line";

	}
}

# count how many 0's are in @l
my $count = 0;
$count++ for grep { $_ == 0 } @l;
say "Number of 0's: $count";
