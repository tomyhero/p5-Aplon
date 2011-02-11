use Test::Most;
use lib 't/';
use_ok( 'TestLogic::Fail');

my $logic = TestLogic::Fail->new();

eval {
    $logic->do_something();
}; 

if(my $error_obj = $@){
    isa_ok($error_obj ,'App::Logic::Error');
}

done_testing();
