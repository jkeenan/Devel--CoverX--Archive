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

{
    my $tdir = tempdir(CLEANUP => 1);
    chdir $tdir or croak "Unable to change to $tdir for testing";
    mkdir 'foo', 0777;
    local $@;
    eval {
        $self = Devel::CoverX::Archive->new( {
            coverage_dir => 'foo',
        } );
    };
    like($@, qr/Could not locate unique coverage database/,
        "new(): Got expected error message for missing coverage database");
    chdir $cwd or croak "Unable to change back to $cwd after testing";
}

{
    my $tdir = tempdir(CLEANUP => 1);
    chdir $tdir or croak "Unable to change to $tdir for testing";
    my $dir = 'foo';
    mkdir $dir, 0777;
    my $f = "$dir/cover.13";
    touch($f);
    local $@;
    eval {
        $self = Devel::CoverX::Archive->new( {
            coverage_dir => $dir,
        } );
    };
    like($@, qr/Could not locate 'digests' file/,
        "new(): Got expected error message for missing digests file");
    chdir $cwd or croak "Unable to change back to $cwd after testing";
}

{
    my $tdir = tempdir(CLEANUP => 1);
    chdir $tdir or croak "Unable to change to $tdir for testing";
    my $dir = 'foo';
    mkdir $dir, 0777;
    my $f = "$dir/cover.13";
    touch($f);
    $f = "$dir/digests";
    touch($f);
    my $subdir = "$dir/runs";
    make_path($subdir, { mode => 0777 });

    local $@;
    eval {
        $self = Devel::CoverX::Archive->new( {
            coverage_dir => $dir,
        } );
    };
    like($@, qr/Could not locate 'structure' directory underneath/,
        "new(): Got expected error message for missing structure directory");
    chdir $cwd or croak "Unable to change back to $cwd after testing";
}

{
    my $tdir = tempdir(CLEANUP => 1);
    chdir $tdir or croak "Unable to change to $tdir for testing";
    my $dir = 'foo';
    mkdir $dir, 0777;
    my $f = "$dir/cover.13";
    touch($f);
    $f = "$dir/digests";
    touch($f);
    my $subdir = "$dir/runs";
    make_path($subdir, { mode => 0777 });
    $subdir = "$dir/structure";
    make_path($subdir, { mode => 0777 });
    my $archive_dir = 'bar';

    $self = Devel::CoverX::Archive->new( {
        coverage_dir => $dir,
        archive_dir => $archive_dir,
    } );
    isa_ok ($self, 'Devel::CoverX::Archive');
    is($self->get_archive_dir(), $archive_dir,
        "Archive directory created where it did not previously exist");
    chdir $cwd or croak "Unable to change back to $cwd after testing";
}

my $tdir = setup_testing_dir();
my $udir = run_cover_on_sample_files($tdir);
my $cover_db_dir = verify_cover_has_been_run($tdir);

$self = Devel::CoverX::Archive->new( {
    coverage_dir => $cover_db_dir,
} );
isa_ok ($self, 'Devel::CoverX::Archive');
is($self->{coverage_dir}, $cover_db_dir,
    "Got expected coverage directory");
is($self->{archive_dir}, 'archive',
    "Got expected archive directory");

done_testing;
