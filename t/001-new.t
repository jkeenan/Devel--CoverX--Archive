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

#say STDERR "tdir: ", $tdir;
#say STDERR `ls -l "$tdir/blib/lib/auto/Alpha"`;
#say STDERR `ls -l "$tdir/blib/lib/auto"`;
#say STDERR "cover_db_dir: ", $cover_db_dir;
$self = Devel::CoverX::Archive->new( {
    coverage_dir => $cover_db_dir,
} );
#isa_ok ($self, 'Devel::CoverX::Archive');
#is($self->{coverage_dir}, $cover_db_dir,
#    "Got expected coverage directory");
#is($self->{archive_dir}, 'archive',
#    "Got expected archive directory");

done_testing;
