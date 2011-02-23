use Test::Most;
use lib 't/';
use_ok( 'TestModel::Fail');

my $model = TestModel::Fail->new();

eval {
    $model->do_something();
}; 

if(my $error_obj = $@){
    isa_ok($error_obj ,'Aplon::Error');
}

done_testing();
