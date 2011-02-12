use Test::Most;
use lib './t/';
SKIP: {

eval { require Data::FormValidator; };
skip "Data::FormValidator not installed", 2 if $@;

use_ok('TestLogic::DFV');

my $logic = TestLogic::DFV->new();

# ok
{
    is($logic->get_id(3),3,'get_id');
    is($logic->get_name({ name => 'hoge', status => 1 }),'hoge','get_name');
}

# missing
{
    eval { $logic->get_id(); }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->missing ,['user_id'],'get_id misssing');
        is_deeply($error_obj->error_keys ,['dfv.user_id.missing'], 'get_id misssing error_keys');
        is_deeply($error_obj->messages ,['user id is missing'],'get_id missing message');
    }

    eval { $logic->get_name({ name => '', status => 1 })  }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->missing ,['name'] , 'get_name missing'); 
        is_deeply($error_obj->error_keys ,['dfv.name.missing'] , 'get_name missing error_keys');
        is_deeply($error_obj->messages ,['name is missing'] , 'get_name missing message');
    }
}

# invalid  
{
    eval { $logic->get_id('hoge'); }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->invalid,{user_id => [ 'invalid' ] } , 'get_id invalid' ); 
        is_deeply($error_obj->error_keys ,['dfv.user_id.invalid'] , 'get_id invalid error_keys');
    }

    eval { $logic->get_name({ name => 'a a padifoja pafsodfij apdfoij', status => 1 }) }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->invalid,{ name => [ 'max_length','invalid'] } ,'get_name invalid'); 
        is_deeply($error_obj->error_keys ,['dfv.name.invalid','dfv.name.max_length'] , 'get_name invalid error_keys');
    }
}

# custom invalid  
{
    eval { $logic->get_name({ name => 'aaaa', status => 0 }) }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->custom_invalid,[ 'not_found' ] ,'get_name custom invalid'); 
        is_deeply($error_obj->error_keys ,['dfv.custom_invalid.not_found'] , 'get_name cutom invalid error_keys');
    }
}

}

done_testing();

