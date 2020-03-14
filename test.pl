use strict;
 
my @test = (
  0, #  1, load module 
  0, #  2, test default port
  0, #  3, test configured port
  0, #  4, test two different ports
  0, #  5, test same ports for failure
);
my $test  = @test;
print "1..".$test."\n";

our $loaded;
our $debug = 0;
 
BEGIN { $| = 1; }
END   { print "not ok $test\n" unless $loaded; }  

{
  $test   = 1;
  $loaded = 0;
  use JoeDog::Plock;

  $loaded = 1;
  print "ok $test\n";
}


{
  $test   = 2;
  $loaded = 0;
  use JoeDog::Plock;

  my $lock = new JoeDog::Plock();
  $lock->set_debug() if $debug;

  if (! $lock->lock()) {
    die("Port Already lock, please check if already running!\n");
  }
  $lock->unlock();

  print "\n" if $test[1];
  $loaded = 1;
  print "ok $test\n";
}

{
  $test   = 3;
  $loaded = 0;
  use JoeDog::Plock;

  my $lock = new JoeDog::Plock(55555);
  $lock->set_debug() if $debug;

  if (! $lock->lock()) {
    die ("Port Already lock, please check if already running!\n");
  }
  $lock->unlock();

  print "\n" if $test[1];
  $loaded = 1;
  print "ok $test\n";
}

{
  $test   = 4;
  $loaded = 0;
  
  my $lockA = new JoeDog::Plock(55555);
  my $lockB = new JoeDog::Plock(55556);
  $lockA->set_debug() if $debug;
  $lockB->set_debug() if $debug;

  if (! $lockA->lock()) {
    die ("Port Already lock, please check if already running!\n");
  }
  if (! $lockB->lock()) {
    die ("Port Already lock, please check if already running!\n");
  }
  $lockA->unlock();
  $lockB->unlock();

  print "\n" if $test[1];
  $loaded = 1;
  print "ok $test\n";
}

{
     $test   = 5;
  my $okay   = 0;
     $loaded = 0;

  my $lockA = new JoeDog::Plock(55555);
  my $lockB = new JoeDog::Plock(55555);
  $lockA->set_debug() if $debug;
  $lockB->set_debug() if $debug;

  if (! $lockA->lock()) {
    die ("Port Already lock, please check if already running!\n");
  }
  if (! $lockB->lock()) {
    $okay = 1; 
  }
  $lockA->unlock();
  $lockB->unlock();

  print "\n" if $test[1];
  $loaded = 1;
  if ($okay) {
    print "ok $test\n";
  } else {
    print "fail $test\n";
  }
}


