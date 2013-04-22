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
which your test suite exercises (or "covers") the source code in a Perl
library.  It is designed to be used in conjunction with Paul Johnson's
Devel::Cover (F<http://search.cpan.org/dist/Devel-Cover/>) library from CPAN,
along with its associated command-line utilities F<cover>, F<cpancover> and
F<gcov2perl>.  (In principle, howver, Devel::CoverX::Archive could be used
with any coverage library which stores its results in the same format as
Devel::Cover.

=head2 Antecedents

Devel::CoverX::Archive was inspired by Thomas Klausner's pioneering effort in
this area, App::ArchiveDevelCover
(F<http://search.cpan.org/dist/App-ArchiveDevelCover/>).

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

=head1 BUGS

=head1 SUPPORT

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

