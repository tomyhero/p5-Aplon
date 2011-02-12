use inc::Module::Install;
name 'App-Logic';
all_from 'lib/App/Logic.pm';

requires (
    'Mouse' => 0,
    'CGI::Carp' => 0,
);

recommends (
    'Data::FormValidator' => 0,
);

test_requires (
    'Test::Most' => 0,
);
tests 't/*.t';

build_requires 'Test::More';
auto_include;
WriteAll;
