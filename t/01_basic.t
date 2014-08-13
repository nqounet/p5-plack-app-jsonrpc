use strict;
use Test::More 0.98;

use Plack::App::JSONRPC;
use Plack::Test;
use HTTP::Request::Common qw(POST);

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

sub json_req {
    POST '/',
      'Content-Type' => 'application/json',
      Content        => shift;
}

my $test = Plack::Test->create($app);
subtest 'echo' => sub {
    my $res = $test->request(
        json_req('{"jsonrpc":"2.0","method":"echo","params":"ok","id":1}'));

    ok $res->is_success, 'request';
    like $res->decoded_content, qr/\Q"result":"ok"\E/, 'response echo';
};

subtest 'notification' => sub {
    my $res = $test->request(
        json_req('{"jsonrpc":"2.0","method":"echo","params":"ok"}'));
    like $res->status_line, qr/^204/, 'response no content';
};

subtest 'empty' => sub {
    my $res = $test->request(
        json_req('{"jsonrpc":"2.0","method":"empty","params":"ok","id":1}'));

    ok $res->is_success, 'request';
    like $res->decoded_content, qr/\Q"result":""\E/, 'response echo';
};
done_testing;

