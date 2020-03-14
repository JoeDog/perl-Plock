package JoeDog::Plock;
use IO::Socket;
use vars qw($VERSION);

$VERSION = '1.0.1';
my  $portlock = undef;
my  $debug    = 0;
use constant  DEFAULT_PORT => 26400;

$| = 1;

=head1 SYNOPSIS

  JoeDog::Plock - A perl extension to ensure just one copy of a running application. 
                  Plock stands for Port LOCK. This method is particularly useful if
                  your application runs on an NFS volume.

  use JoeDog::Plock;

  my $lock = new JoeDog::Plock(55555);
  if (! $lock->lock()) {
    print "A copy of $0 is already running....\n";
    exit(1);
  }

  # put your script here....

  $lock->unlock();
  exit;

=head1 METHODS

=item B<new>

  $lock = new JoeDog::Plock([optional_number]);

  JoeDog::Plock constructor; returns a reference to a JoeDog::Plock object.
  If this constructor is called with no parameters, it uses the default port (26400). 
  You can override that port number with an optional number. We suggest you pick ports
  between 10000 and 60000.

=cut

sub new {
  my $type = shift;
  my $self = {};
  $self->{'port'}  = $_[0];
  $self->{'debug'} = 0;
  $self->{'port'}  = (int($self->{'port'}) <= 0) ? DEFAULT_PORT : $self->{'port'}; 
  bless $self, $type;
}

=item B<lock>

  $lock->lock() 

  This is our test to see if a copy of our script is already running. Consider this
  example:

  if (! $lock->lock()) {
    print "A copy of $0 is already running.\n";
    exit(1);
  }
=cut

sub lock() {
  my $this = shift;
  my $port = $this->{'port'};

  $portlock = new IO::Socket::INET (
    LocalHost => 'localhost',
    LocalPort => $port,
    Proto     => 'tcp',
    Listen    => 1
  );

  $this->debug("lock() :: port ($port) ok");
  unless($portlock) {
    return 0;
  }

  return 1;
}

=item B<lock>
  
  $lock->unlock()
 
  Remove the Port LOCK by closing the socket.

=cut
sub unlock() {
  my $this = shift;
  if (defined($portlock)) {
    close($portlock);
  }

  $portlock= undef;
  $this->debug("unlock() :: ok");
}


sub debug() {
  my $this = shift;
  my (@parm) = (@_);
  my $msg = join(' : ',@parm);
  my $scr = "Ver$VERSION";

  if ($this->{'debug'} > 0) {
    print "$scr - $msg\n";
  }
}

=item B<set_debug()>
  $conf->set_debug();

  This options turns on debugging. It tells JoeDog::Plock to print what it reads to STDOUT;

=cut
sub set_debug(){
  my $this = shift;
  $this->{"debug"} = 1;
  return;
}


1;
