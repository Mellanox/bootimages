%global debug_package %{nil}

Name: mlxbf-aarch64-firmware
Version: 3.7.0.11805
Release: 1%{?dist}
Summary: Boot images (ATF, UEFI, etc) for Mellanox BlueField

License: BSD and ASL 2.0
Url: https://github.com/Mellanox/bootimages
Source: %{name}-%{version}.tar.gz

ExclusiveArch: aarch64
Provides: mlxbf-bootimages = %{version}

%description
Binary files for ATF, UEFI, etc for Mellanox BlueField hardware.
These files are required for booting BlueField chips, and are installed
by using bfrec, included in the mlxbf-bfscripts package.

%prep
%setup

%build
exit 0

%install
%{__make} install DESTDIR=%{buildroot}

%files
%defattr(644, root, root)
/lib/firmware/mellanox/boot/*
%doc README.md
%license LICENSE licenses/*

%changelog
* Thu Aug 5 2021 Spencer Lingard <spencer@nvidia.com> - 3.7.0.11805-1
- Update to 3.7.0.11805

* Thu May 20 2021 Spencer Lingard <spencer@nvidia.com> - 3.6.0.11699-1
- Update to 3.6.0.11699

* Wed Jan 20 2021 Spencer Lingard <spencer@nvidia.com> - 3.5.0.11563-1
- Update to 3.5.0.11563

* Thu Sep 24 2020 Spencer Lingard <spencer@nvidia.com> - 3.1.0.11424-1
- Update to 3.1.0.11424
- Generate tarball name
- Upgrade SRPM makefile
- Move install logic to makefile

* Fri Jul 31 2020 Spencer Lingard <spencer@nvidia.com> - 3.0.0.11348~beta1-1
- Update version stamp
- Use just %setup
- Add version data to source tarball name
- Add Provides: mlxbf-bootimages for compatability with old package name

* Thu Jul 30 2020 Spencer Lingard <spencer@nvidia.com> - 3.0.beta1.11348-1
Update to 3.0.beta1.11348

* Wed Jun 10 2020 Spencer Lingard <spencer@nvidia.com> - 3.0.beta1-2
Initial packaging.
