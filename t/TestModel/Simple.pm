package TestModel::Simple ;
use Mouse;
extends 'TestModel::Base';
with 'Aplon::Validator::Simple';


sub error01 {
    my $self = shift;
    $self->abort_with({
        custom_invalid => [ 'name01','name02'],
        missing => ['name03','name04'],
        invalid => { 
            name04 => [ 'toolong','toosmall'],
            name05 => [ 'toolong','ascii'],
        }
    });

}



__PACKAGE__->meta->make_immutable();

no Mouse;

1;
