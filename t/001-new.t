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
is($self->get_coverage_dir, $cover_db_dir,
    "Got expected name for coverage directory");
ok(-d $self->get_coverage_dir, "coverage directory exists");

my ($exp_archive_dir, $exp_diff_dir);
$exp_archive_dir = "$tdir/archive";
is($self->get_archive_dir, $exp_archive_dir,
    "Got expected name for archive directory");
ok(-d $self->get_archive_dir, "archive directory exists");

$exp_diff_dir = "$tdir/diff";
is($self->get_diff_dir, $exp_diff_dir,
    "Got expected name for diff directory");
ok(-d $self->get_diff_dir, "diff directory exists");

is_deeply($self->get_archives(), [],
    "As expected at this point, no archives found");

done_testing;
