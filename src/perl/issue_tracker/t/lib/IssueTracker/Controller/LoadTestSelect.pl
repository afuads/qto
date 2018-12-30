use strict ; use warnings ; 
use Test::Most; 
use Test::Mojo;
use Data::Printer ; 
use FindBin;

die_on_fail ; 

BEGIN { unshift @INC, "$FindBin::Bin/../../../../../issue_tracker/lib" }

   my $tm = '' ; # the test message for each test 
   my $t = Test::Mojo->new('IssueTracker');
   my $appConfig = $t->app->get('AppConfig') ; 
   # if the product instance id tst -> tst_issue_tracker
   my $db_name= $appConfig->{ 'postgres_db_name' } ; 
   my $url = '/' . $db_name . '/select-tables' ; 

   $t->get_ok($url)
      ->status_is(200) 
      ->header_is('Accept-Charset' => 'UTF-8')
      ->header_is('Accept-Language' => 'fi, en')
      ->content_like(qr/daily_issues/);
   ;

   my $ua  = $t->ua ; 

use Mojo::IOLoop;

my $d = Mojo::IOLoop->delay(sub {  print 'finish' });

my @uas;

print "perform 500 asyncronous $url GET requests \n" ; 
# for 550 the following error occurs:
# Mojo::Reactor::EV: Timer failed: Handle is closed at /usr/local/share/perl/5.26.0/Mojo/IOLoop/Client.pm line 180.
for (0 .. 500) {
  # debug print "get $url run-". "$_" . "\n" ; 
  push @uas, my $ua = $t->ua ;
  $ua->get($url => $d->begin);
  $ua->get('/' . $db_name . '/select-tables' => $d->begin );
}

$d->wait;



## foreach table in the app db in test call db/select/table
#for my $row ( @$list ) {
#
#   my $table_name = $row->{'table_name'} ; 
#   my $url = '' ; 
#   my $tm = '' ; # the test msg 
#
#   # feature-guid: 1d270227-0959-488f-83d3-0397221385a0
#	$t->get_ok('/' . $db_name . '/select/' . $table_name)
#		->status_is(200) 
#		->header_is('Accept-Charset' => 'UTF-8')
#		->header_is('Accept-Language' => 'fi, en')
#	;
#
#   # feature-guid: ac8a79af-9114-42e6-86eb-9bc29f7c0190
#
#   $url = '/' . $db_name . '/select/' . $table_name ; 
#   my $res = $ua->get('/' . $db_name . '/select/' . $table_name )->result->json ; 
#   $tm .= 'the response msg for the ' . $table_name . " for the url: $url is empty" ; 
#   ok ( $res->{'msg'} eq "" , $tm) ; 
#
#   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
#   ok ( $res->{'ret'} == 200 , $tm) ; 
#}
#
#   # feature-guid: dfc1216d-5a16-40eb-849a-2785264aa5bd
#	my $table_name = 'non_existent_table' ; 
#	$t->get_ok('/' . $db_name . '/select/' . $table_name)
#		->status_is(400) 
#		->header_is('Accept-Charset' => 'UTF-8')
#		->header_is('Accept-Language' => 'fi, en')
#	;
#
#   # feature-guid: 8d750499-4911-416c-ae81-b3415d13b5ef
#   my $res = $ua->get('/' . $db_name . '/select/' . $table_name )->result->json ; 
#   $tm = '2: the response msg for the ' . $table_name . ' is correct' ; 
#   ok ( $res->{'msg'} eq " the table $table_name does not exist in the $db_name database " , $tm ) ; 
#
#   $tm = 'the return code for the ' . $table_name . ' is correct' ; 
#   ok ( $res->{'ret'} == 400 , $tm) ; 
#   
#   $res = $ua->get('/non_existent_db/select/monthly_issues'  )->result->json ; 
#   $tm = 'shoud return error for cannot connect to db' ; 
#   my $exp_err_msg = 'cannot connect to the "non_existent_db" database: FATAL:  database "non_existent_db" does not exist' ; 
#   ok ( $res->{'msg'} eq $exp_err_msg , $tm ) ; 
#
#	$tm = 'if the page size is not a positive whole number return http 400 ' ; 
#   my $page_size = 'not_even_a_number' ; 
#   my $page_num = 1 ; 
#   $url = '/' . $db_name . '/select/tst_paging?as=table&pg-size=' . $page_size .'&pg-num=' . $page_num ; 
#   $t->get_ok( $url )->status_is(400 , $tm ) ; 
#	
#   $tm = 'if the page num is not a positive whole number return http 400 ' ; 
#   $page_size = 15 ; 
#   $page_num = 'not_even_a_number' ; 
#   $url = '/' . $db_name . '/select/tst_paging?as=table&pg-size=' . $page_size .'&pg-num=' . $page_num ; 
#   $t->get_ok( $url )->status_is(400 , $tm ) ; 

# fetch all the tables 
done_testing();

# feature-guid: ecd424d7-e5bd-45f1-90c8-10fae1316bf9
