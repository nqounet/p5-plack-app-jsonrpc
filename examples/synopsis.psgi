use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Plack::App::JSONRPC;

use Plack::Builder;

my $jsonrpc = Plack::App::JSONRPC->new(
    methods => {
        echo  => sub { $_[0] },
        empty => sub {''}
    }
);
my $app = sub { [204, [], []] };
builder {
    mount '/jsonrpc', $jsonrpc->to_app;
    mount '/' => $app;
};
