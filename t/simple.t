use Test::Most;
use lib './t';

use TestModel::Simple;
my $model = TestModel::Simple->new();
eval { $model->error01(); };

if(my $error_obj = $@){

    is_deeply([sort(@{$error_obj->error_keys})], [
        'model.custom_invalid.name01',
        'model.custom_invalid.name02',
        'model.name03.missing',
        'model.name04.invalid.toolong',
        'model.name04.invalid.toosmall',
        'model.name04.missing',
        'model.name05.invalid.ascii',
        'model.name05.invalid.toolong'
    ]);


}

done_testing();
