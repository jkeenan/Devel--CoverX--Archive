package testdata::setup;
use strict;
use warnings;
use 5.010;
our @ISA = ( 'Exporter' );
our @EXPORT_OK = qw(
    setup_testing_dir
    run_devel_cover
    run_cover_on_sample_files
    verify_cover_has_been_run
    touch
);
use Carp;
use Cwd;
use Path::Class;
use File::Copy::Recursive qw(dircopy);
use File::Path qw(make_path);
use File::Temp qw(tempdir);
*ok = *Test::More::ok;
*is = *Test::More::is;
*like = *Test::More::like;
*is_deeply = *Test::More::is_deeply;

sub setup_testing_dir {
    my $samplepkg = 'Alpha-0.01';
    my $sampledir = "./t/testdata/$samplepkg";
    ok(-d $sampledir, "Found sample code for testing");
    my $top_tdir =
        Path::Class::Dir->new(tempdir(CLEANUP=>$ENV{NO_CLEANUP} ? 0 : 1));
    ok(-d $top_tdir, "Created top tempdir $top_tdir for testing");
    my $tdir = Path::Class::Dir->new($top_tdir, $samplepkg);
    make_path($tdir, { mode => 0777 });
    ok(-d $tdir, "Created tempdir $tdir for testing");
    dircopy($sampledir, $tdir) or die $!;
    return $tdir;
}

sub run_devel_cover {
    my $tdir = shift;
    my $cwd = cwd();
    chdir $tdir or croak "Unable to change to tempdir";
    local $ENV{HARNESS_PERL_SWITCHES} = '-MDevel::Cover';
    system(qq{$^X Makefile.PL && make && make test})
        and croak "Unable to run make and make test";
    chdir $cwd or croak "Unable to change directory";;
    return 1;
}

sub run_cover_on_sample_files {
    my $tdir = shift;
    my $cwd = cwd();
    chdir $tdir or croak "Unable to change to tempdir";
    system(qq{cover -report text > /dev/null})
        and croak "Unable to run cover";
    chdir $cwd or croak "Unable to change directory";;
    return 1;
}

sub verify_cover_has_been_run {
    my $tdir = shift;
    ok(-d $tdir, "$tdir exists for testing");
    my $cover_db_dir = "$tdir/cover_db";
    ok(-d $cover_db_dir, "cover_db/ exists for testing");
    ok(-f "$cover_db_dir/digests", "Found digests file");
    ok(-d "$cover_db_dir/runs", "Found runs directory");
    ok(-d "$cover_db_dir/structure", "Found structure directory");
    return $cover_db_dir;
}

sub touch {
    my ($file, $content) = @_;
    $content ||= '';
    open my $F, '>', $file or croak "Unable to open $file for writing";
    print $F "$content\n";
    close $F or croak "Unable to close $file after writing";
}

1;

__END__
#use File::Temp qw(tempdir);
#use Path::Class;
#use File::Copy::Recursive qw(dircopy);

#sub tmpdir {
#    my $tempdir = Path::Class::Dir->new(tempdir(CLEANUP=>$ENV{NO_CLEANUP} ? 0 : 1));
#    return $tempdir;
#}
#
#my %runs = (
#    'run_1' => 1329762000, #2012-02-20T19:20:00
#    'run_2' => 1329766800, #2012-02-20T20:40:00
#);
#
#sub run {
#    my ($tempdir, $run) = @_;
#    my $src = Path::Class::dir(qw(t testdata),$run);
#
#    dircopy($src,$tempdir->subdir($run)) || die $!;
#    my $mtime = $runs{$run};
#    utime($mtime,$mtime,$tempdir->file($run,'coverage.html')->stringify);
#    return $tempdir->subdir($run);
#}

