package Devel::CoverX::Archive;
use strict;
our $VERSION = '0.01';

sub new {
    my ($class, $args) = @_;
    my %data = ();

    return bless \%data, $class;
}

=head1 NAME

Devel::CoverX::Archive - Track improvements in test coverage

=head1 SYNOPSIS

  use Devel::CoverX::Archive;

  $self = Devel::CoverX::Archive->new( \%options );

=head1 DESCRIPTION

Devel::CoverX::Archive enables you to track improvements in the extent to
which your test suite exercises (or I<covers>) the source code in a Perl
library.  It is designed to be used in conjunction with Paul Johnson's
Devel::Cover (F<http://search.cpan.org/dist/Devel-Cover/>) library from CPAN,
along with its associated command-line utilities F<cover>, F<cpancover> and
F<gcov2perl>.  (In principle, howver, Devel::CoverX::Archive could be used
with any coverage library which stores its results in the same format as
Devel::Cover.)

=head2 Antecedents

Devel::CoverX::Archive was inspired by Thomas Klausner's pioneering effort in
this area, App::ArchiveDevelCover
(F<http://search.cpan.org/dist/App-ArchiveDevelCover/>).  Unlike that library,
Devel::CoverX::Archive gathers its coverage data by calls to Devel::Cover's
own coverage database rather than by parsing the HTML output of F<cover>.

=head1 USAGE

Anyone intending this library should already be familiar with Devel::Cover and
its associated command-line utility F<cover>.

=head2 When Do I I<Not> Need Devel::CoverX::Archive?

If (a) you are writing a B<new> Perl library, (b) follow a more-or-less
test-driven style of development, and (c) periodically measure your test
coverage with F<cover>, then you probably don't need to use
Devel::CoverX::Archive.  If you follow those practices, the coverage reports
will prompt you to write tests for untested parts of your source code and your
coverage ratios will stay very close to 100% at all times.  Hence, you will
have little need to track B<changes> in those coverage ratios over time.

=head2 When Should I Use Devel::CoverX::Archive?

You should use Devel::CoverX::Archive when the existing test coverage of a
library is low and when improving that coverage will require several rounds of
writing new tests and running coverage analysis.  

=head2 Where Would Devel::CoverX::Archive Fit Into My Workflow?

If you wish to record data from a given round of coverage analysis, run the
F<archive_coverage> command-line utility after you run F<cover>.  Example:

    # hack, hack, hack
    cover -delete
    perl Makefile.PL
    make
    HARNESS_PERL_SWITCHES=-MDevel::Cover make test
    cover
    archive_coverage

    # Examine coverage results, identify untested code
    # hack, hack, hack
    cover -delete
    perl Makefile.PL (# if Makefile.PL has been modified)
    make
    HARNESS_PERL_SWITCHES=-MDevel::Cover make test
    cover
    archive_coverage
    
    # Compare results of last two round of coverage analysis
    # Repeat as needed

=head2 Where Can I See the Coverage Results?

By default, F<archive_coverage> will store its data and its HTML
representations of that data in a directory called F<archive/> located
immediately beneath your top-level directory.  In other words, F<archive/>
will be located at the same level as the F<cover_db/> directory created by
running Devel::Cover itself.

TODO: Offer a command-line option to locate the archive elsewhere.

TODO: Document how the directory holding a given run will be named.

=head2 What Coverage Data Will Be Retained from One Run of F<archive_coverage> to the Next?

By default, F<archive_coverage> will retain the coverage data for each run.
However, to economize on disk space, it will by default only retain two sets
of HTML outputs:  the most recent run, and the run immediately before that.
If you want to regenerate HTML output for another run of F<archive_coverage>,
simple C<chdir> to that run's directory and run F<cover>.

=head2 How Can I Designate Runs of F<archive_coverage> for More Permanent Storage

There are cases where you will want to retain the HTML output of a given run
of F<archive_coverage>.  For example, if you are working with others on improving the
testing coverage of a major Perl library found on the CPAN, you may wish to
track your progress on a public web site which permanently records the coverage
analysis for each version of the library released to CPAN.  It is the author's
hope that Devel::CoverX::Archive will be used to track the testing coverage of
Perl 5 subversions from one monthly release to the next.

TODO: Determine how this will work.  Perhaps the command-line option
C<--benchmark>.

=head1 BUGS AND LIMITATIONS

This code should be considered I<alpha>.  All interfaces are subject to change
without prior announcement.

Please report bugs at
F<https://rt.cpan.org/Ticket/Create.html?Queue=Devel-CoverX-Archive>.

=head1 AUTHOR

    James E Keenan
    CPAN ID: JKEENAN
    jkeenan@cpan.org
    http://thenceforward.net/perl

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

perl(1). Devel::Cover(3);

=cut

#################### main pod documentation end ###################


1;
