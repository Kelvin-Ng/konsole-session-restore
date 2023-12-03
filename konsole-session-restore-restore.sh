#!/bin/bash

# Restore the previously saved Konsole sessions
# https://docs.kde.org/trunk5/en/applications/konsole/command-line-options.html
#
# Adapted from https://unix.stackexchange.com/a/593779/41618

SAVE_FILES="$(dirname $(realpath -s $0))"/data/*

for file in $SAVE_FILES; do
    konsole --tabs-from-file "${file}" -e 'bash -c exit' &
done

