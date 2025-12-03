
use v5.40;


my $v = 50;
my $oldv;
my $spot_on = 0;

while (my $line = <>) {
	chomp $line;

    if ($line =~ /([L,R])(\d+)/) {
		my $direction = $1;
		my $steps = $2;
		# say "  Direction: $direction, Steps: $steps";
		$oldv = $v;
		while ($steps > 0) {
			if ($direction eq 'R') {
				$v++;
				if ($v == 100) {
					$v = 0;
				}
			} elsif ($direction eq 'L') {
				$v--;
				if ($v == -1) {
					$v = 99;
				}
			} else {
				die "Unknown direction: $direction";
			}
			if ($v == 0) {
				$spot_on++;
			}
			$steps--;
		}
		# say "Previous: $oldv\t Direction: $direction,Steps: $2\t New: $v\t Full turns: $spot_on";

	} else {
		die "No match found on line $.: $line";
	}
}

say "Number of 0s: $spot_on";
