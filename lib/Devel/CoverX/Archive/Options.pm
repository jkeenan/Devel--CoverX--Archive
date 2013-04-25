package Devel::CoverX::Archive::Options;
use strict;
our @ISA = qw( Exporter );
our @EXPORT_OK = qw(
    parse_command_line
    usage
);
our $VERSION = '0.01';
use Getopt::Long;
use Carp;

sub parse_command_line {
    my %opts = ();

    my $result = GetOptions(\%opts,
        'benchmark',
        'help',
        'verbose!',
        'coverage_dir',
        'archive_dir',
    );
    usage("-") if defined $opts{help};    # see if the user asked for help
    $opts{help} = ''; # just to make -w shut-up.
    return \%opts;
}

sub usage {
    die <<END_OF_USAGE;
Usage:  $0 --benchmark --help --verbose --cover_dir=cover_db --archive_dir=archive
END_OF_USAGE
}

1;

