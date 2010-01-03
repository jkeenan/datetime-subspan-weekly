#perl
use strict;
use warnings;
use DateTime::Subspan::Weekly qw( in_range );
use Test::More qw(no_plan); # tests => 1;

my $starting_date = { day => 6, hour => 0, minute => 0, second => 0 };
my $range_ref = { days => 5, hours => 20, minutes => 0, seconds => 0 };
my ($dt, $rv);

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 1,
   hour   => 12,
   minute => 36,
   second => 47,
   time_zone => 'America/New_York',
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok(! $rv, "$dt is not in range");

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 2,
   hour   => 12,
   minute => 36,
   second => 47,
   time_zone => 'America/New_York',
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok($rv, "$dt is in range");

$starting_date = { day => 6, hour => 16, minute => 0, second => 0 };

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 1,
   hour   => 12,
   minute => 36,
   second => 47,
   time_zone => 'America/New_York',
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok(! $rv, "$dt is not in range");

$starting_date = { day => 5, hour => 16, minute => 0, second => 0 };

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 1,
   hour   => 12,
   minute => 36,
   second => 47,
   time_zone => 'America/New_York',
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok(! $rv, "$dt is not in range");

$starting_date = { day => 5, hour => 16, minute => 0, second => 0 };

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 1,
   hour   => 17,
   minute => 36,
   second => 47,
   time_zone => 'America/New_York',
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok($rv, "$dt is in range");

$dt = DateTime->new(
   year   => 2010,
   month  => 1,
   day    => 2,
   hour   => 12,
   minute => 36,
   second => 47,
   time_zone => 'America/New_York',
);
$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );
ok($rv, "$dt is in range");
