# te_fpm

####Table of Contents

1. [Overview](#overview)
1. [Usage](#usage)
  1. [Class te_fpm](#class-te_fpm)
  1. [Defined type te:fpm::build](#defined-type-te_fpmbuild)
    1. [Examples](#examples)
    1. [Parameters](#parameters)

##Overview

The te_fpm module manages the framework for FPM and package builds.

##Usage

Apply the `te_fpm` class to the build server and name builds in a profile.

###Class te_fpm

No parameters; just include the class.

```
include te_fpm
```

This does the following:

* install git
* install rpm-build
* install fpm gem

###Defined type te_fpm::build

Use this to track individual repositories and build packages.

####Examples

```
te_fpm::build { 'test_module':
  version => '0.1.0',
  repo    => 'https://github.com/WhatsARanjit/test_module.git',
}

te_fpm::build { 'test_module_puppet':
  version => '0.1.1',
  repo    => 'https://github.com/WhatsARanjit/test_module.git',
  type    => 'deb',
  arch    => 'x86_64',
}
```

####Parameters

__version__:

A version number that should match the tag of the repository which holds the code.  _Required_

__repo__:

The URI to the repo that holds the package content.  _Required_

__content__:

Directory where the repository content will be downloaded to. _Default_: `"/tmp/${title}"`

__package__:

Name of the package to be created. _Default_: `$title`

__source__:

The FPM source for the package. _Default_: 'dir'

Complete list of sources: https://github.com/jordansissel/fpm#things-that-are-in-the-works-or-should-work

__arch__:

Architecture can be specified if package is not agnostic.  'all' is used for agnostic packages. __Default__: 'all'

__type__:

Kind of package that is created.  _Default_: 'rpm'

Complete list of types: https://github.com/jordansissel/fpm#things-that-are-in-the-works-or-should-work

__dest__:

Where on disk you want the final package to be deposited.  _Default_: '/tmp'
