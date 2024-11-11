#!/bin/env bash
# This expects QEMU to be in the parent directory. Use the QEMU git (do not forget submodules) and checkout the tag you want, DO NOT USE the source archives available on the website (they just don't work).
# We specifically use the edk pulled by QEMU, but one could adapt this to use the edk repo directly
cd ../qemu/roms/

./edk2-build.py --config edk2-build.config
