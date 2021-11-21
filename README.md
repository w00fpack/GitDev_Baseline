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
