package Plack::App::JSONRPC;
use 5.008001;
use strict;
use warnings;
our $VERSION = "0.01";

use parent qw(Plack::Component);
use JSON::RPC::Spec;
use Plack::Request;

sub call {
    my ($self, $env) = @_;
    my $rpc = JSON::RPC::Spec->new;
    while (my ($name, $callback) = each %{$self->{method}}) {
        $rpc->register($name, $callback);
    }
    my $req = Plack::Request->new($env);
    my $body = $rpc->parse($req->content);
    if (length $body) {
        return [200, ['Content-Type' => 'application/json'], [$body]];
    }
    return [204, [], []];
}

1;
__END__

=encoding utf-8

=head1 NAME

Plack::App::JSONRPC - Yet another JSON-RPC 2.0 psgi application

=head1 SYNOPSIS

    # app.psgi
    use Plack::App::JSONRPC;
    my $app = Plack::App::JSONRPC->new(
        method => {
            echo => sub { $_[0] }
        }
    );
    $app->to_app;

    # run
    $ plackup app.psgi

=head1 DESCRIPTION

Plack::App::JSONRPC is Yet another JSON-RPC 2.0 psgi application

=head1 LICENSE

Copyright (C) nqounet.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

nqounet E<lt>mail@nqou.netE<gt>

=cut

