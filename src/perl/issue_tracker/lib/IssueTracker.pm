package IssueTracker;

use Mojo::Base 'Mojolicious';

use strict ; use warnings ; 
use utf8;
use strict;
use autodie;
use warnings;
use warnings qw< FATAL  utf8     >;
use open qw< :std  :utf8     >;
use charnames qw< :full >;
use feature qw< unicode_strings >;

use Data::Printer ; 
use Cwd qw ( abs_path );
use File::Basename qw< basename >;
use Carp qw< carp croak confess cluck >;
use Encode qw< encode decode >;
use Unicode::Normalize qw< NFD NFC >;


# use own modules ...
use IssueTracker::App::Utils::Initiator;
use IssueTracker::App::Utils::Configurator;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Mdl::Model ; 


my $module_trace 					= 0;
our $objConfigurator				= {} ; 
our $objInitiator 				= {};
our $appConfig    				= {};
our $objLogger 					= {};
our $objModel                 = {};


# This method will run once at server start
sub startup {

   my $self = shift;
   my $ret = 1 ; 
   my $msg = '' ; 

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  ($ret, $msg) = $self->doInitialize();
  
   # Router
   my $r = $self->routes;

	# http://host-name:3000/dev_issue_tracker/select-tables
   $r->get('/:db/select-tables')->to(
     controller   => 'Select'
   , action       => 'doSelectTables'
   );
   
   # http://host-name:3000/dev_issue_tracker/select/monthly_issues
   $r->get('/:db/select/:item')->to(
     controller   => 'Select'
   , action       => 'doSelectItems'
   );
   # http://host-name:3000/dev_issue_tracker/select/monthly_issues
   $r->get('/:db/select-meta/:item')->to(
     controller   => 'Select'
   , action       => 'doSelectMeta'
   );
   
   
   # http://host-name:3000/dev_issue_tracker/select/monthly_issues
   $r->get('/:db/list/:item')->to(
     controller   => 'List'
   , action       => 'doListItems'
   );

}


sub doInitialize {

   my $self = shift ; 
   my $msg = 'error during initialization !!!';
   my $ret = 1;

   $objInitiator = 'IssueTracker::App::Utils::Initiator'->new();
   $appConfig    = $objInitiator->get('AppConfig');

   my $ConfFile = q{} ; 
   if ( defined $ENV->{ 'conf_file' } ) {
      $ConfFile = $ENV->{ 'conf_file' } ; 
   } else {
      $ConfFile = $objInitiator->{'ConfFile'} ; 
   }

   $objConfigurator  = 'IssueTracker::App::Utils::Configurator'->new( 
         $ConfFile, \$appConfig);
   $objLogger        = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);

   p($appConfig) ; 
   $self->set('AppConfig' , $appConfig );
   $self->set('ObjLogger', $objLogger );

   $msg = "START MAIN";
   $objLogger->doLogInfoMsg($msg);

   $ret = 0;
   return ($ret, $msg);
}
# eof sub doInialize


# -----------------------------------------------------------------------------
# return a field's value - aka the "getter"
# chk: http://perldoc.perl.org/Carp.html
# -----------------------------------------------------------------------------
sub get {

   my $self = shift;
   my $name = shift;
   croak "\@TRYING to get an undef name" unless $name ;  
   croak "\@TRYING to get an undefined value" unless ( $self->{"$name"} ) ; 

   return $self->{ $name };
}    


# -----------------------------------------------------------------------------
# set a field's value - aka the "setter"
# -----------------------------------------------------------------------------
sub set {

   my $self  = shift;
   my $name  = shift;
   my $value = shift;
   $self->{ "$name" } = $value;
}
# eof sub set

# -----------------------------------------------------------------------------
# return the fields of this obj instance
# -----------------------------------------------------------------------------
sub dumpFields {
   my $self      = shift;
   my $strFields = ();
   foreach my $key ( keys %$self ) {
      $strFields .= " $key = $self->{$key} \n ";
   }

   return $strFields;
}    

1;
