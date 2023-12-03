#!/bin/bash

# Restore the previously saved Konsole sessions
# https://docs.kde.org/trunk5/en/applications/konsole/command-line-options.html
#
# Adapted from https://unix.stackexchange.com/a/593779/41618

XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
SAVE_PATH="$XDG_DATA_HOME"/konsole-session-restore
SAVE_FILES="$SAVE_PATH"/*

for file in $SAVE_FILES; do
    konsole --tabs-from-file "${file}" -e 'bash -c exit' &
done

