#!/bin/bash

set -x
set -eu

cpanm --notest Dist::Zilla 
dzil authordeps --missing | cpanm --notest
dzil listdeps --missing | cpanm --notest

set +eu
set +x
