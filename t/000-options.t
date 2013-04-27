# t/000_options.t
use strict;
use warnings;
use Test::More;
use lib ( './lib' );
use Devel::CoverX::Archive::Options qw(
    parse_command_line
    usage
);
use IO::CaptureOutput qw( capture );

my $opts = parse_command_line();
is( ref($opts), 'HASH',
    "parse_command_line() returned hashref" );

{
    local $@ = undef;
    eval { usage(); };
    like($@, qr/Usage:\s+$0.*--help/s,
        "Got expected help output for usage() with no arguments");
}

{
    my ($stdout, $stderr);
    my $unk = 'foo';
    capture(
        sub { system(qq{./bin/archive_coverage --$unk}); },
        \$stdout,
        \$stderr,
    );
    like($stderr, qr/$unk/, "Detected unknown option");
}

done_testing();
