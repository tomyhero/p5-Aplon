use inc::Module::Install;
name 'Aplon';
all_from 'lib/Aplon.pm';

requires (
    'Mouse' => 0,
    'CGI::Carp' => 0,
);

recommends (
    'Data::FormValidator' => 0,
    'FormValidator::LazyWay' => 0,
);

test_requires (
    'Test::Most' => 0,
);
tests 't/*.t';

build_requires 'Test::More';
auto_include;
WriteAll;
