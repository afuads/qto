package Qto::Controller::BaseController ; 
use strict ; use warnings ; 

use Mojo::Base 'Mojolicious::Controller';
use Data::Printer ; 

our $module_trace    = 0 ; 
our $appConfig       = {};
our $objLogger       = {} ;
our $rdbms_type      = 'postgres' ; 

use Qto::App::Mdl::Model ; 
use Qto::App::Db::In::RdrDbsFactory ; 
use Qto::App::Cnvr::CnrHsr2ToHsr2 ; 


sub doResolveDbName {
   my $self                = shift ; 
   my $db                  = shift ; 
   my $item                = shift ; 
   my @env_prefixes        = ( 'dev_' , 'tst_' , 'qas_' , 'prd_' );
 
   my $db_prefix           = substr($db,0,4);
   $appConfig		 		   = $self->app->get('AppConfig');
   unless ( grep ( /^$db_prefix$/, @env_prefixes)) {
      $db = $appConfig->{ 'ProductType' } . '_' . $db ; 
   } 
   return $db ;
}


sub doReloadProjDbMeta {

   my $self                = shift ;
   my $db                  = shift ;
   my $item                = shift || '' ; 

   $appConfig		 		   = $self->app->get('AppConfig');

   # reload the columns meta data ONLY after the meta_columns has been requested
   return if ( exists ( $appConfig->{ $db . '.meta' } ) && $item ne 'meta_columns' ); 

   my $objRdrDbsFactory    = {} ; 
   my $objRdrDb            = {} ; 
   my $msr2                = {} ; 
   my $ret                 = 1 ; 
   my $msg                 = "fatal error while reloading project database meta data " ; 
   my $objModel            = {} ; 

   $objModel               = 'Qto::App::Mdl::Model'->new ( \$appConfig ) ;
   $objModel->set('postgres_db_name' , $db ) ; 
    
   $objRdrDbsFactory       = 'Qto::App::Db::In::RdrDbsFactory'->new( \$appConfig, \$objModel );
   $objRdrDb               = $objRdrDbsFactory->doSpawn( $rdbms_type );
   ($ret, $msg , $msr2 )   = $objRdrDb->doLoadProjDbMeta( $db ) ; 

   $appConfig->{ "$db" . '.meta' } = $msr2 ; # chk: it-181101180808
   $self->app->set('AppConfig', $appConfig );
   $self->render('text' => $msg ) unless $ret == 0 ; 
}


sub isAuthorized {

   my $self                = shift ;
   my $db                  = shift ;
   $appConfig		 		   = $self->app->get('AppConfig');

   my $htpasswd_file = $appConfig->{ 'ProductInstanceDir'} . '/cnf/sec/passwd/' . $db . '.htpasswd' ;

   return 1 unless -f $htpasswd_file ;  # open by default !!! ( temporary till v0.5.1 )
   return 1 if $self->basic_auth(
      $db => {
         'path' => $htpasswd_file
      }
   );

   $self->render('text' => 'Refresh your page to login ');
   return 0  ;

}


# 
# call-by : $self->SUPER::doRenderJSON($http_code,$msg,$http_method,$met,$cnt,$dat);
#
sub doRenderJSON {

   my $self          = shift ; 
   my $http_code     = shift ; 
   my $msg           = shift ; 
   my $http_method   = shift || 'GET' ; 
   my $met           = shift ; # the meta data
   my $cnt           = shift ; # the count of the data
   my $dat           = shift ; # the data 
   my $req           = "$http_method " . $self->req->url->to_abs ; 

   unless ( $cnt ) {
      $cnt              = @{$dat} if ( $dat ); 
   }

   $self->res->headers->content_type('application/json; charset=utf-8');
   $self->res->code($http_code);
   $self->render( 'json' =>  { 
        'ret'   => $http_code
      , 'msg'   => $msg
      , 'req'   => $req
      , 'met'   => $met
      , 'cnt'   => $cnt
      , 'dat'   => $dat
   });
}

1;

__END__
