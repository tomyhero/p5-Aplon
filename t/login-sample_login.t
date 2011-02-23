use Test::Most;
use lib './t';
use_ok('TestModel::Model::SampleLogin');

my $model = TestModel::Model::SampleLogin->new();


# ok
{
    my $session = {};
    $model->login(
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
    eval { $model->login({},{ callback => sub {} } ) };
    if(my $error_obj = $@){
        is_deeply($error_obj->missing ,['password','email'],'misssing');
        is_deeply($error_obj->error_keys ,['model.password.missing','model.email.missing'], 'misssing error_keys');
    }
}

# login fail
{
    eval { $model->login({ email => 'hoge@hogehogehoge.hoge', password => '1111' },{ callback => sub {} } ) };
    if(my $error_obj = $@){
        is_deeply($error_obj->custom_invalid ,['login_failed'],'login fail custom_invalid');
        is_deeply($error_obj->error_keys ,['model.custom_invalid.login_failed'],'login fail error_keys');
    }

}

done_testing();
