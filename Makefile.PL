

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'DateTime::Subspan::Weekly',
    VERSION_FROM => 'lib/DateTime/Subspan/Weekly.pm', # finds \$VERSION
    AUTHOR       => 'James E Keenan (jkeenan@cpan.org)',
    ABSTRACT     => 'Determine whether event falls within weekly recurring range',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                    },
);
