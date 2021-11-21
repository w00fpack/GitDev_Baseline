#1/bin/bash

PATH1="./vanilla"

if [ -d "$PATH1" ]; then
	echo  "$PATH1' already exists.  exiting"
	exit 1
fi

mkdir -p "$PATH1/src"
mkdir -p "$PATH1/test"

# --- helloworld.c ------------------------------
cat > "$PATH1/src/helloworld.c" <<EOF
#include <stdio.h>
int main() {
   // printf() displays the string inside quotation
   printf("\n2.0.0\n");
   return 0;
}
EOF

# --- Makefile.am ------------------------------
cat > "$PATH1/Makefile.am" << EOF
AUTOMAKE_OPTIONS = subdir-objects
bin_PROGRAMS = myapp

myapp_SOURCES = \
	src/helloworld.c \

EOF

# --- test1.cc ------------------------------
cat > "$PATH1/test/test1.cc" <<EOF
#include <stdio.h>
#include <stdlib.h>
#include <stdexcept>

void test1()
{
	throw std::runtime_error(   std::string( __FILE__ ) \
		+ std::string( ":" ) \
		+ std::to_string( __LINE__ ) \
		+ std::string( " in " ) \
		+ std::string( __PRETTY_FUNCTION__ ) \
	);
}

int main ()
{
  test1();
}
EOF

# --- test Makefile.am ------------------------------
top_srcdir="."
top_builddir="."

cat > "$PATH1/test/Makefile.am" << EOF
AM_CPPFLAGS = \
	-I$top_srcdir \
#	-DCUR_WORKING_DIR='"@BASE_CUR_WORKING_DIR@/test"'

#AM_CFLAGS = @LIBFLTK_CFLAGS@
#AM_CXXFLAGS = @LIBFLTK_CXXFLAGS@

noinst_PROGRAMS = \
	test1

test1 = test1.cc
#test1_LDADD = \
#	$top_builddir/dw/libDw-core.a \
#	@LIBFLTK_LIBS@ @LIBX11_LIBS@
EOF

cat > "$PATH1/README.md"<<EOF
Note: work in progress

# Overview
This is a baseline for setting up a vanilla C repository for Linux code.
An action is also defined to create releases with artifacts.  To use the Action, push a tag starting with "v", (e.g. "v1.0.0")

# Building example output from Release Source

This repository does not include Autotools generated files.  Only files coded/needed by a developer are in this repository.  Releases in this repository have Autotools files included.

To build from a release's source code, uncompress a source release file and change into it's directory.  Then run the following command:


>mkdir -p build
>
>cd build
>
>../configure --prefix=/usr
>
>make
>
>make check
>
>make installcheck
>

To test and/or install, run the following commands:

>make install
>
>myapp
>


# How to compile from git source
Releases have Autotools generated files to help you build the example source code.  However, if you would like to build the source code from the GitHub repository, you can generate the Autotools files by doing the following:

>git clone https://github.com/w00fpack/GitDev_Baseline.git"
>
>cd GitDev_Baseline
>
>
>
>autoscan
>
>mv configure.scan configure.ac
>
>
>
>sed -i "s/AC_INIT(\[FULL-PACKAGE-NAME\], \[VERSION\], \[BUG-REPORT-ADDRESS\])/AC_INIT(\[myapp\], \[0.0.1\], \[\])/g" configure.ac
>
>sed -i "s/AC_CONFIG_HEADERS(\[config.h\])/AC_CONFIG_HEADERS(\[config.h\])\nAM_INIT_AUTOMAKE(\[-Wall -Werror foreign\])/g" configure.ac
>
>
>
>autoreconf -vi
>
>chmod 744 configure
>
>
>
>mkdir -p "build"
>
>cd "build"
>
>../configure --prefix=/usr
>
>make
>
>make check
>
>make installcheck
>
>./myapp
>


# Recreating this Repository
This repository can be used  as a reference, template and tutorial.  The following steps should explain how to go about setting up a vanilla C project in a GitHub repository.

* Make an empty repository on Github
* Open a terminal and type

>./vanilla_setup.sh

* In your GitHub repository, add the release_w_artifact.yml from  here as an Actions > New Workflow
* Code > Releases > Code/Draft a new release to trigger Actions
Actions should also be triggerable by a git tag request.  This is being worked on.
EOF

cp vanilla_setup.sh "$PATH1"
cp release_w_artifact.yml "$PATH1"
#mkdir -p  "$PATH1/.github/workflows/"
#cp release_w_artifact.yml "$PATH1/.github/workflows/release_w_artifact.yml"


# --- Git ------------------------------
cd "$PATH1"
git init
git add .

git commit -m "first commit"
git rev-list --date-order --all --pretty

# --- Messages to Run Commands ------------------------------
echo "__________________________________________________"
echo "All Set UP.  Now send the following commands
  (update to your personal settings)"
echo
echo 'cd vanilla/'
echo 'git config --global user.email "<your@email.address.com>"'
echo 'git config --global user.name "<your_password>"'
echo 'git remote add origin https://github.com/<your_username>/<your_repository>.git'
echo 'git push --set-upstream origin master'
# --- tag  ------------------------------
echo 'git tag "v1.0.0"'
echo 'git push origin --tags'
echo
