PROJECT_NAME:=mlxbf-aarch64-firmware

RPKG_NAME:=$(PROJECT_NAME).spec.rpkg
SPEC_NAME:=$(PROJECT_NAME).spec
PROJECT_NAME:=$(shell rpmspec -q --qf "%{name}" $(SPEC_NAME))
RPM_BASE:=$(shell \
  rpmspec -q --qf "%{name}-%{version}-%{release}" $(SPEC_NAME))
SRPM_NAME:=$(RPM_BASE).src.rpm
TAR_BASE:=$(shell \
  rpmspec -q --qf "%{name}-%{version}" $(SPEC_NAME))
TAR_NAME:=$(TAR_BASE).tar.gz
GIT_FILES:=$(shell git ls-files -co --exclude-standard)

.PHONY: all clean spec
all: $(SRPM_NAME)

clean:
	rm -r RPMBUILD
	rm -r git_dir_pack
	rm -f $(PROJECT_NAME)*.src.rpm

# Generates the spec file, commit this when rpkg file changes.
# REQUIRES RPKG-UTIL
spec:
	rpkg spec --outdir . --spec $(RPKG_NAME)

RPMBUILD/SOURCES/$(TAR_NAME): $(GIT_FILES)
	mkdir -p RPMBUILD/SOURCES
	rm -rf git_dir_pack
	mkdir -p git_dir_pack/$(TAR_BASE)
	rsync --relative $(GIT_FILES) git_dir_pack/$(TAR_BASE)
	(cd git_dir_pack; tar -zcvf ../$@ $(TAR_BASE))

$(SRPM_NAME): RPMBUILD/SOURCES/$(TAR_NAME) $(SPEC_NAME)
	rpmbuild -bs --define "_topdir $(shell pwd)/RPMBUILD" $(SPEC_NAME)
	cp RPMBUILD/SRPMS/$(SRPM_NAME) ./
