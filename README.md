## Bio::VertRes::Permissions
Update permissions of files efficiently in parallel.

[![Build Status](https://travis-ci.org/sanger-pathogens/Bio-VertRes-Permissions.svg?branch=master)](https://travis-ci.org/sanger-pathogens/Bio-VertRes-Permissions)   
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-brightgreen.svg)](https://github.com/sanger-pathogens/Bio-VertRes-Permissions/blob/master/GPL-LICENSE)   

## Contents
* [Introduction](#introduction)
* [Installation](#installation)
  * [From source](#from-source)
  * [Running the tests](#running-the-tests)
* [Usage](#usage)
* [License](#license)
* [Feedback/Issues](#feedbackissues)

## Introduction
Take in a list of directories located on multiple disk arrays and update the permissions of the files efficiently in parallel.
The directories are first partitioned into different disk arrays. Multiple arrays are processed in parallel, with multiple threads per array.

## Installation
Details for installing Bio::VertRes::Permissions are provided below. If you encounter an issue when installing Bio::VertRes::Permissions please contact your local system administrator. If you encounter a bug please log it [here](https://github.com/sanger-pathogens/Bio-VertRes-Permissions/issues) or email us at path-help@sanger.ac.uk.

### From source
Clone the repository:   
   
`git clone https://github.com/sanger-pathogens/Bio-VertRes-Permissions.git`   
   
Move into the directory and install all dependencies using [DistZilla](http://dzil.org/):   
  
```
cd Bio-VertRes-Permissions
dzil authordeps --missing | cpanm
dzil listdeps --missing | cpanm
```
  
Run the tests:   
  
`dzil test`   
If the tests pass, install Bio-VertRes-Permissions:   
  
`dzil install`   

### Running the tests
The test can be run with dzil from the top level directory:  
  
`dzil test`  

## Usage
```
Usage: update_pipeline_file_permissions [options]
Changes the permissions of all files in a set of directories

Options: -t STR    type [file_of_directories]
         -i STR    input filename of directories []
         -u STR    username [pathpipe]
         -g STR    unix group [pathogen]
         -o STR    file permissions in octal [0750]
         -l INT    directory level to split on [2]
         -d INT    threads per disk array [1]
         -p INT    num disk arrays to process in parallel [1]
         -v        verbose output to STDOUT
         -h        this help message

Example: Run with defaults
         update_pipeline_file_permissions -i file_of_directories.txt

Example: Update group to team81 in parallel
         bsub.py --threads 16 5 log update_pipeline_file_permissions -i file_of_directories.txt -d 4 -p 4 -g team81
```
## License
Bio::VertRes::Permissions is free software, licensed under [GPLv3](https://github.com/sanger-pathogens/Bio-VertRes-Permissions/blob/master/GPL-LICENSE).

## Feedback/Issues
Please report any issues to the [issues page](https://github.com/sanger-pathogens/Bio-VertRes-Permissions/issues) or email path-help@sanger.ac.uk.
