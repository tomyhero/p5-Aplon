use inc::Module::Install;
name 'App-Logic';
all_from 'lib/App/Logic.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
