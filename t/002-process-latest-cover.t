use strict;
use warnings;
use Test::More;
use lib ( './t', './lib' );
use Devel::CoverX::Archive;

use Carp;
use Cwd;
use File::Path qw(make_path);
use File::Temp qw(tempdir);
use IO::CaptureOutput qw(capture);

use testdata::setup qw(
    setup_testing_dir
    run_devel_cover
    run_cover_on_sample_files
    verify_cover_has_been_run
    touch
);

#my $dt_str = '2012-02-20T18:20:00';

my $self;
my $cwd = cwd();

# test error conditions in new()
{
    local $@;
    eval {
        $self = Devel::CoverX::Archive->new( {
            coverage_dir => 'foo',
        } );
    };
    like($@, qr/Cannot locate 'foo' directory/,
        "new(): Got expected error message for missing coverage directory ");
}

my $tdir = setup_testing_dir();
run_devel_cover($tdir);
run_cover_on_sample_files($tdir);
my $cover_db_dir = verify_cover_has_been_run($tdir);

# A valid Devel::CoverX::Archive object

$self = Devel::CoverX::Archive->new( {
    coverage_dir => $cover_db_dir,
    archive_dir  => "$tdir/archive",
    diff_dir     => "$tdir/diff",
} );
isa_ok ($self, 'Devel::CoverX::Archive');

ok($self->process_latest_cover(),
    "process_latest_cover(): returned true value");

done_testing;

