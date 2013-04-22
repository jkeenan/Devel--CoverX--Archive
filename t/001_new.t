use strict;
use warnings;
use Test::More;
use lib ( './lib' );
use Devel::CoverX::Archive;

my $self = Devel::CoverX::Archive->new ();
isa_ok ($self, 'Devel::CoverX::Archive');


done_testing;
