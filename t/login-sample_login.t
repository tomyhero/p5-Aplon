use Test::Most;
use lib './t';
use_ok('TestLogic::Logic::SampleLogin');

my $logic = TestLogic::Logic::SampleLogin->new();


# ok
{
    my $session = {};
    $logic->login(
        { email => 'tomohiro.teranishi@gmail.com' , password => '1111' },
        {
            callback => sub {
                my $args = shift;
                $session->{logininfo}  = $args;
            }
        }
    ) ;
    is($session->{logininfo}{name} ,'tomohiro.teranishi', 'login');
}

# missing
{
    eval { $logic->login({},{ callback => sub {} } ) };
    if(my $error_obj = $@){
        is_deeply($error_obj->missing ,['password','email'],'misssing');
        is_deeply($error_obj->error_keys ,['logic.password.missing','logic.email.missing'], 'misssing error_keys');
    }
}

# login fail
{
    eval { $logic->login({ email => 'hoge@hogehogehoge.hoge', password => '1111' },{ callback => sub {} } ) };
    if(my $error_obj = $@){
        is_deeply($error_obj->custom_invalid ,['login_failed'],'login fail custom_invalid');
        is_deeply($error_obj->error_keys ,['logic.custom_invalid.login_failed'],'login fail error_keys');
    }

}

done_testing();
