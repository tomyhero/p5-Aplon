package TestLogic::Validator::FL;
use Mouse::Role;
use YAML::Syck();
use Data::Section::Simple;
with 'App::Logic::Validator::FormValidator::LazyWay';

our $FV;
sub FL_instance {
    my $self = shift;
    if($TestLogic::Validator::FV){
        return $TestLogic::Validator::FV;
    }
    else {
        my $reader = Data::Section::Simple->new('TestLogic::Validator::FL');
        my $yaml = $reader->get_data_section('validate.yaml');
        my $config = YAML::Syck::Load( $yaml);
        my $lw = FormValidator::LazyWay->new( config => $config);
        $TestLogic::Validator::FV = $lw;
        return $lw;
    }
}

1;


__DATA__
@@ validate.yaml
lang: en
rules:
    - Number
    - String
setting:
    strict:
        user_id : 
            rule :
            - Number#uint
        status : 
            rule :
            - Number#range:
                min : 0   
                max : 1
        name : 
            rule :
            - String#length:
                max: 10
                min: 1
            - String#nonsymbol_ascii
