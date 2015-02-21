package Rapi::Fs::Model::DB;
use Moo;
extends 'Catalyst::Model::DBIC::Schema';

use strict;
use warnings;

use Path::Class qw(file);
use Catalyst::Utils;
my $db_path = file(Catalyst::Utils::home('Rapi::Fs'),'rapi_fs.db');

__PACKAGE__->config(
    schema_class => 'Rapi::Fs::DB',
    
    connect_info => {
       dsn => "dbi:SQLite:$db_path",
       user => '',
       password => '',
       sqlite_unicode => q{1},
       on_connect_call => q{use_foreign_keys},
       quote_names => q{1},
    },

    # Configs for the RapidApp::RapidDbic Catalyst Plugin:
    RapidDbic => {

       # use only the relationship column of a foreign-key and hide the 
       # redundant literal column when the names are different:
       hide_fk_columns => 1,

       # grid_params are used to configure the grid module which is 
       # automatically setup for each source in the navtree

       grid_params => {
          # The special '*defaults' key applies to all sources at once
          '*defaults' => {
             include_colspec      => ['*'], #<-- default already ['*']
             ## uncomment these lines to turn on editing in all grids
             #updatable_colspec   => ['*'],
             #creatable_colspec   => ['*'],
             #destroyable_relspec => ['*'],
          }
       },
    
       
       # TableSpecs define extra RapidApp-specific metadata for each source
       # and is used/available to all modules which interact with them
       TableSpecs => {
          'Directory' => {
          },
          'File' => {
          },
          'FileMeta' => {
          },
          'Realm' => {
          },
       },
    }

);

# ------
# Auto-deploy:
before 'setup' => sub {
  my $self = shift;
  return if (-f $db_path);
  $self->schema_class->connect($self->connect_info->{dsn})->deploy;
};
# ------


=head1 NAME

Rapi::Fs::Model::DB - Catalyst/RapidApp DBIC Schema Model

=head1 SYNOPSIS

See L<Rapi::Fs>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Rapi::Fs::DB>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema::ForRapidDbic - 0.65

=head1 AUTHOR

root

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
