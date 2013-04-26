

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Devel::CoverX::Archive',
    VERSION_FROM => 'lib/Devel/CoverX/Archive.pm', # finds \$VERSION
    AUTHOR       => 'James E Keenan (jkeenan@cpan.org)',
    ABSTRACT     => 'Track improvements in test coverage',
    PREREQ_PM    => {
                     'Test::Simple' => 0.98,
                     'IO::CaptureOutput' => 0,
                     'Path::Class' => 0,
                     'File::Copy::Recursive' => 0,
                     'File::Path' => 0,
                     'File::Temp' => 0,
                    },
);
