%define    _topdir /usr/src/redhat
%define    _unpackaged_files_terminate_build 0
Name:      JoeDog-Plock
Summary:   A file lock system for NFS
Version:   1.0.1
Release:   2%{?dist}
BuildArch: noarch
Group:     Programming
License:   GPL
Source:    ftp://ftp.joedog.org/pub/JoeDog/%{name}-%{version}.tar.gz
BuildRoot: /var/tmp/%{name}-buildroot
AutoReq:   0

%description
A file lock system for NFS

%prep 
%setup -q 

%install
cp --verbose -a ./ $RPM_BUILD_ROOT/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)

%dir /usr/share/perl5/vendor_perl/JoeDog
/usr/share/man/man3/JoeDog::Plock.3pm.gz
/usr/share/perl5/vendor_perl/JoeDog/Plock.pm

%changelog

