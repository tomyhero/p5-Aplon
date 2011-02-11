use Test::Most;
use lib './t/';
SKIP: {

eval { require Data::FormValidator; };
skip "Data::FormValidator not installed", 2 if $@;

use_ok('TestLogic::DFV');

my $logic = TestLogic::DFV->new();

# ok
{
    is($logic->get_id(3),3);
    is($logic->get_name({ name => 'hoge', status => 1 }),'hoge');
}

# missing
{
    eval { $logic->get_id(); }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->missing ,['user_id']);
        is_deeply($error_obj->error_keys ,['dfv.user_id.missing']);
        is_deeply($error_obj->messages ,['user id is missing']);
    }

    eval { $logic->get_name({ name => '', status => 1 })  }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->missing ,['name']); 
        is_deeply($error_obj->error_keys ,['dfv.name.missing']);
        is_deeply($error_obj->messages ,['name is missing']);
    }
}

# invalid  
{
    eval { $logic->get_id('hoge'); }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->invalid,{user_id => [ 'invalid' ] } ); 
        is_deeply($error_obj->error_keys ,['dfv.user_id.invalid']);
    }

    eval { $logic->get_name({ name => 'a a padifoja pafsodfij apdfoij', status => 1 }) }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->invalid,{ name => [ 'max_length','invalid'] } ); 
        is_deeply($error_obj->error_keys ,['dfv.name.invalid','dfv.name.max_length']);
    }
}

}

done_testing();

