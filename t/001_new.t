use strict;
use warnings;
use Test::More;
use lib ( './t', './lib' );
use Devel::CoverX::Archive;

use IO::CaptureOutput qw(capture);

use testdata::setup qw(
    setup_testing_dir
    run_cover_on_sample_files
    verify_cover_has_been_run
);

#my $dt_str = '2012-02-20T18:20:00';

my $tdir = setup_testing_dir();
my $udir = run_cover_on_sample_files($tdir);
my $cover_db_dir = verify_cover_has_been_run($tdir);

my $self;

$self = Devel::CoverX::Archive->new( {
    coverage_dir =>$cover_db_dir,
} );;
isa_ok ($self, 'Devel::CoverX::Archive');


done_testing;
