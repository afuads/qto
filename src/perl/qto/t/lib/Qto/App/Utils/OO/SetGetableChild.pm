use strict ; use warnings ; 

package Qto::App::Utils::OO::SetGetableChild ; 

	require Exporter;
	our @ISA = qw(Exporter  Qto::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;

use base qw(Qto::App::Utils::OO::SetGetable);


=head2 new
=cut 

	sub new {
		my $class = shift;    # Class name is in the first parameter
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  


1 ; 

__END__
