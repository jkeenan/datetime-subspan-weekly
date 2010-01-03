package DateTime::Subspan::Weekly;
use strict;
use Carp;
use DateTime;
use DateTime::Duration;
use DateTime::Set;
use DateTime::Span;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT_OK);
    $VERSION     = '0.01';
    @ISA         = qw(Exporter);
    @EXPORT_OK   = qw(
        in_range
    );
}

sub in_range {
    my $args = shift;
    my $sixdays = DateTime::Duration->new( days  => 6 );
    my $oneweek = DateTime::Duration->new( weeks => 1 );

    my $dt1 = $args->{target}->clone();
    $dt1->set(
        hour    => $args->{starting_date}->{hour},
        minute  => $args->{starting_date}->{minute},
        second  => $args->{starting_date}->{second},
    );

    my $starting_date_minus_6 = $dt1 - $sixdays;

    my $spanweek = DateTime::Span->from_datetime_and_duration( 
        start => $starting_date_minus_6, duration => $oneweek );

    my $set = DateTime::Set->from_recurrence( 
        recurrence => sub {
            return $_[0] if $_[0]->is_infinite;
            return $_[0]->add( days => 1 )
        },
        span => $spanweek,
    );

    my $start_of_span = _get_start_of_span( $args->{starting_date}, $set );

    my $allowable_range = DateTime::Duration->new( %{ $args->{range} } );

    my $span_allow = DateTime::Span->from_datetime_and_duration( 
        start       => $start_of_span,
        duration    => $allowable_range
    );

    _date_is_in_span( $args->{target}, $span_allow );
}

sub _get_start_of_span {
    my ($starting_date, $set) = @_;
    my $iter = $set->iterator;
    my $starting_dt;
    while ( my $x = $iter->next ) {
        if ( $x->dow eq $starting_date->{day} ) {
            $starting_dt = $x->clone();
            last;
        }
    };
    return $starting_dt;
}

sub _date_is_in_span {
    my ( $date, $span ) = @_;
    $span->contains( $date ) ? 1 : 0;
}

#################### DOCUMENTATION ###################


=head1 NAME

DateTime::Subspan::Weekly - Determine whether event falls within weekly recurring range

=head1 SYNOPSIS

    use DateTime::Subspan::Weekly qw( in_range );

    $rv = in_range( {
        starting_date   => $starting_date,  # Hash ref
        range           => $range_ref,      # Hash ref
        target          => $dt,             # DateTime object
    } );

=head1 DESCRIPTION

Suppose that a 'week' can begin at an arbitrarily chosen day of the week and
time of day.  Suppose further that that week can be divided into two subspans:
one in which an event is permitted to occur, and the other in which the event
is not permitted to occur.

DateTime::Subspan::Weekly provides functions to determine a particular date
falls in the permitted range or not.

=head1 SUBROUTINES

DateTime::Subspan::Weekly currently exports one subroutine on request.

=head2 C<in_range()>

=over 4

=item * Purpose

Determine whether or not a given date falls within the permitted subspan of a
'week' beginning at a given date within a normal week.

=item * Arguments

Takes a single hash reference with 3 required elements:

    $rv = in_range( {
        starting_date   =>
            { day => 6, hour => 0, minute => 0, second => 0 },
        range           =>
            { days => 5, hours => 20, minutes => 0, seconds => 0 },
        target          => DateTime->new(
            year   => 2010,
            month  => 1,
            day    => 1,
            hour   => 12,
            minute => 36,
            second => 47,
        ),
    } );

=over 4

=item * C<starting_date>

Hash reference with elements keyed as C<day>, C<hour>, C<minute> and
C<second>.  These elements describe the date in the normal DateTime week
(I<i.e.,> a 'week' where Monday is C<1> and Sunday is C<7>) at which the
'permitted subspan' begins.  In the example above, the permitted subspan
begins Friday at 0000 hours.

=item * C<range>

Hash reference with elements keyed as C<days>, C<hours>, C<minutes> and
C<seconds>.  These elements describe the duration of the permitted subspan,
beginning at the C<starting_date>.  In the example above, the permitted
subspan lasts for 5 days and 20 hours, C<i.e.,> until the following Wednesday
at 2000 hours.

=item * C<target>

DateTime object representing the date and time being tested to determine
whether it is in the permitted range or not.  If not provided, will default to
C<DateTime-I<gt>now()>, the equivalent of C<localtime>.
In the example above, January 1, 2010, 12::36::47 is being
tested to determine whether it falls in the period beginning at
C<starting_date> and lasting for C<range>.

=back

=item * Return Value

Returns true value if date falls within permitted range.  Returns false if
date does not fall within permitted range.

=back


$rv = in_range( {
    starting_date => $starting_date,
    range        => $range_ref,
    target       => $dt,
} );


=head1 BUGS AND LIMITATIONS

This is very much alpha code; the interface may change at any time.  In
particular, the interface may change to an object-oriented one to become more
consistent with the rest of the DateTime ecosphere.

Not yet tested for daylight-savings-time boundaries, leap years, etc.

=head1 SUPPORT

Bugs:  http://rt.cpan.org.  General support:  email to author at address
below.

=head1 AUTHOR

    James E Keenan
    CPAN ID: jkeenan
    jkeenan@cpan.org
    http://search.cpan.org/~jkeenan/

=head1 COPYRIGHT

Copyright 2010 James E Keenan.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=head1 PREREQUISITES

Requires the DateTime and DateTime-set distributions from CPAN.

=cut

1;

