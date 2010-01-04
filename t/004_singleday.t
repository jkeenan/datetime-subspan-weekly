#perl
use strict;
use warnings;
use DateTime::Subspan::Weekly qw( in_range );
use Test::More tests =>  3;

# Test cases where permitted range occurs entirely within one calendar day

my ($dt, $rv, $starting_date, $range_ref);

$range_ref = { days => 0, hours => 3, minutes => 0, seconds => 0 };

my %dt20100101123647 = (
   year   => 2010,
   month  => 1,
   day    => 1,
   hour   => 12,
   minute => 36,
   second => 47,
);
$dt = DateTime->new(
    %dt20100101123647,
);
$starting_date = { day => 5, hour => 15, minute => 0, second => 0 };
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok(! $rv, "$dt is not in range: too early in day which is start of permitted subspan");

$starting_date = { day => 5, hour => 12, minute => 0, second => 0 };
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok($rv, "$dt is in range: datetime is during permitted subspan");

$starting_date = { day => 5, hour => 2, minute => 0, second => 0 };
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok(! $rv, "$dt is not in range: too late in day which is start of permitted subspan");
