use Test::Most;
use lib './t';
SKIP: {

eval { 
    require FormValidator::LazyWay; 
};

skip "FormValidator::LazyWay not installed", 1 if $@;
eval {
    require YAML::Syck; #XXX
    require Data::Section::Simple; #XXX
};

skip "YAML::Syck or Data::Section::Simple not installed", 1 if $@;

use_ok('TestModel::FL');

my $model = TestModel::FL->new();

# ok
{
    is($model->get_id(3),3,'get_id');
    is($model->get_name({ name => 'hoge', status => 1 }),'hoge','get_name');
}

# missing
{
    eval { $model->get_id(); }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->missing ,['user_id'],'get_id misssing');
        is_deeply($error_obj->error_keys ,['model.user_id.missing'], 'get_id misssing error_keys');
        is_deeply($error_obj->messages ,['user id is missing'],'get_id missing message');
    }

    eval { $model->get_name({ name => '', status => 1 })  }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->missing ,['name'] , 'get_name missing'); 
        is_deeply($error_obj->error_keys ,['model.name.missing'] , 'get_name missing error_keys');
        is_deeply($error_obj->messages ,['name is missing'] , 'get_name missing message');
        is_deeply($error_obj->valid ,{ status => 1 }  , 'get_name valid');
    }
}

# invalid  
{
    eval { $model->get_id('hoge'); }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->invalid,{user_id => [ 'Number#uint' ] } , 'get_id invalid' ); 
        is_deeply($error_obj->error_keys ,['model.user_id.invalid.Number#uint'] , 'get_id invalid error_keys');
    }

    eval { $model->get_name({ name => 'a a padifoja pafsodfij apdfoij', status => 1 }) }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->invalid,{ name => [ 'String#length','String#nonsymbol_ascii'] } ,'get_name invalid'); 
        is_deeply($error_obj->error_keys ,['model.name.invalid.String#length','model.name.invalid.String#nonsymbol_ascii'] , 'get_name invalid error_keys');
        is_deeply($error_obj->error_message , { 'name' => 'name supports minimun 1 letters and maximum 10 letters,alphabet, number .'},'get_name invalid error_message');
        is_deeply($error_obj->valid ,{ status => 1 }  , 'get_name valid');
    }
}

# custom invalid  
{
    eval { $model->get_name({ name => 'aaaa', status => 0 }) }; 
    if(my $error_obj = $@){ 
        is_deeply($error_obj->valid ,{ name => 'aaaa',status => 0 }  , 'get_name valid');
        is_deeply($error_obj->custom_invalid,[ 'not_found' ] ,'get_name custom invalid'); 
        is_deeply($error_obj->error_keys ,['model.custom_invalid.not_found'] , 'get_name cutom invalid error_keys');
    }
}

}

done_testing();

