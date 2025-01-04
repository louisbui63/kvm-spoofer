#!/bin/env bash
# This expects QEMU to be in the parent directory. Use the QEMU git (do not forget submodules) and checkout the tag you want, DO NOT USE the source archives available on the website (they just don't work).
# Look at the docker containers they use for testing for a list of dependencies for your distro.
# This only compiles x86_64 as we don't really care about spoofing anything else for the moment (maybe aarch64 at some point ?)
export neoqemu_lower="qemu"

cd ../$neoqemu_lower
./configure --target-list=x86_64-softmmu # we do not compile anything but x86
make -j$(nproc)
