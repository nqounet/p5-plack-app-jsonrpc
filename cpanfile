requires 'perl', '5.008001';
requires 'JSON::RPC::Spec';
requires 'HTTP::Headers::Fast';
requires 'Plack';

on 'test' => sub {
    requires 'Test::More', '0.98';
};
