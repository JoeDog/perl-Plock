JoeDog::Plock - A PERL5 configuration file parser.  

ABSTRACT:  
This is a autoloadable module which allows the programmer 
to ensure there's only one running copy of his script. It  
was designed for file locking on an NFS volume. Instead  
of locking the file, it opens a port and removes the port  
when the task is complete.  
http://www.joedog.org/  

COPYRIGHT  
Plock.pm is copyright 2014 by Jeffrey Fulmer & Tim Funk  
and it is covered by the GNU Public License. See COPYING  
for more details.  

INSTALLATION  
JoeDog::Plock.pm was built using perl Make::Maker utility  
If you are familiar with  that  utility you should have no  
problem with this installation as it will be familiar:  

  $ perl Makefile.PL  
  $ make  
  $ make test  
  $ su  
  $ make install  

USAGE  

  use JoeDog::Plock;  

  my $lock = new JoeDog::Plock(55555);  
  if (! $lock->lock()) {  
    print "A copy of $0 is already running....\n";  
    exit(1);  
  }  

  # put your script here....  

  $lock->unlock();  
  exit;  

For greater detail, see: perldoc JoeDog::Plock.pm  

