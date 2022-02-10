#!/bin/sh

version=1.0.1

mkdir -p JoeDog-Plock-$version
perl Makefile.PL INSTALLDIRS=vendor
make
make test
make install DESTDIR=JoeDog-Plock-$version
rm -Rf JoeDog-Plock-$version/usr/lib64

tar -cvf - JoeDog-Plock-$version | gzip -f > JoeDog-Plock-$version.tar.gz
mv JoeDog-Plock-$version.tar.gz /usr/src/redhat/SOURCES
rpmbuild -ba -v plock.spec
rm -Rf ./JoeDog-Plock-$version
