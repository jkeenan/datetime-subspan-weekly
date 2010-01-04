#perl
use strict;
use warnings;
use DateTime::Subspan::Weekly qw( in_range );
use Test::More tests =>  3;

# Test cases where target datetime occurs on last day of permitted subspan

my ($dt, $rv, $starting_date, $range_ref);

$starting_date = { day => 5, hour => 0, minute => 0, second => 0 };
$range_ref = { days => 5, hours => 20, minutes => 0, seconds => 0 };

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 5,
   hour   => 12,
   minute => 36,
   second => 47,
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok($rv, "$dt is in range: last day of permitted subspan");

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 6,
   hour   => 19,
   minute => 59,
   second => 59,
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok($rv, "$dt is in range: last second of permitted subspan");

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 6,
   hour   => 20,
   minute => 0,
   second => 0,
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok(! $rv, "$dt is not in range: datetime which is start of non-permitted subspan");
