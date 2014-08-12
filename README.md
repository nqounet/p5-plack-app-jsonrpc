[![Build Status](https://travis-ci.org/nqounet/p5-plack-app-jsonrpc.png?branch=master)](https://travis-ci.org/nqounet/p5-plack-app-jsonrpc)
# NAME

Plack::App::JSONRPC - Yet another JSON-RPC 2.0 psgi application

# SYNOPSIS

    # app.psgi
    use Plack::App::JSONRPC;
    my $app = Plack::App::JSONRPC->new(
        register => {
            echo => sub { $_[0] }
        }
    );
    $app->to_app;

    # run
    $ plackup app.psgi

# DESCRIPTION

Plack::App::JSONRPC is Yet another JSON-RPC 2.0 psgi application

# LICENSE

Copyright (C) nqounet.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

nqounet <mail@nqou.net>
