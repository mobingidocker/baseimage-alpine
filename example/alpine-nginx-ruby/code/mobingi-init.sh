#!/bin/bash -ex

cd /srv/code

apk add build-base make gcc autoconf --no-cache

bundle --binstubs bundle_bin
