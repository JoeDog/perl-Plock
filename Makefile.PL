#
# Makefile.PL for JoeDog::Config distribution
#
# Filename:	Makefile.PL
# Author:	Tim Funk
# Created:	20 March 2002
#

use ExtUtils::MakeMaker;

&WriteMakefile(
  ABSTRACT       => 'JoeDog::Plock module',
  VERSION_FROM   => 'Plock.pm',
  PM             => {
    'Plock.pm'   => '$(INST_LIBDIR)/Plock.pm',
  },
  dist           => {
    'COMPRESS'   => 'gzip -9f', 'SUFFIX'      => 'gz',
    'ZIP'        => '/usr/bin/zip','ZIPFLAGS' => '-rl'
  },
  AUTHOR         => 'Jeff Fulmer <jeff@joedog.org> and  Tim Funk <funkman@joedog.org>',
  NAME           => 'JoeDog::Plock'
);
 
