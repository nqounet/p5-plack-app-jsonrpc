use strict;
use Test::More 0.98;

use Plack::App::JSONRPC;
use Plack::Test;
use HTTP::Request::Common;

# use DDP {deparse => 1};

sub factorial {
    my $num = shift;
    return $num > 1 ? $num * factorial($num - 1) : 1;
}

my $app = Plack::App::JSONRPC->new(
    method => {
        echo      => sub { $_[0] },
        empty     => sub {''},
        factorial => \&factorial
    }
);

my $test = Plack::Test->create($app);
my ($res);
subtest 'echo' => sub {
$res = $test->request(POST '/',
    'content-type' => 'application/json',
    Content        => '{"jsonrpc":"2.0","method":"echo","params":"ok","id":1}');

ok $res->is_success, 'request';
like $res->decoded_content, qr/\Q"result":"ok"\E/, 'method echo';
};

subtest 'notification' => sub {
$res = $test->request(POST '/',
    'content-type' => 'application/json',
    Content        => '{"jsonrpc":"2.0","method":"echo","params":"ok"}');
like $res->status_line, qr/^204/, 'notification';
};

subtest 'empty' => sub {
$res = $test->request(POST '/',
    'content-type' => 'application/json',
    Content        => '{"jsonrpc":"2.0","method":"empty","params":"ok","id":1}');

ok $res->is_success, 'request';
like $res->decoded_content, qr/\Q"result":""\E/, 'method echo';
};
done_testing;

