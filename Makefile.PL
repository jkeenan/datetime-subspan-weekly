

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'DateTimeX::Subspan::Weekly',
    VERSION_FROM => 'lib/DateTimeX/Subspan/Weekly.pm', # finds \$VERSION
    AUTHOR       => 'James E Keenan (jkeenan@cpan.org)',
    ABSTRACT     => 'Determine whether event falls within weekly recurring range',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                     'Carp' => 0,
                     'DateTime' => 0,
                     'DateTime::Set' => 0,
                     'DateTime::Span' => 0,
                    },
);
