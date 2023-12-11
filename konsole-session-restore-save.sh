#!/bin/bash

# Obtains Konsole session states through qdubs and saves them so they can be restored easily
# https://docs.kde.org/trunk5/en/applications/konsole/command-line-options.html
#
# Adapted from https://unix.stackexchange.com/a/593779/41618

COMMAND='' # Default command if there is no command for the tab
XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
SAVE_PATH="$XDG_DATA_HOME"/konsole-session-restore
mkdir -p $SAVE_PATH

rm -f "$SAVE_PATH"/*

if [[ "$XDG_SESSION_TYPE" == "wayland" || "$1" == "force" ]] ; then
    pids=$(pgrep 'konsole' -f -u $USER)

    while IFS= read -r pid; do
        if [[ $(readlink -f /proc/$pid/exe) == "/usr/bin/konsole" ]]; then
            SESSIONS=$(qdbus org.kde.konsole-$pid | grep /Sessions/)
            if [[ ${SESSIONS} ]] ; then
                for i in ${SESSIONS}; do
                    FORMAT=$(qdbus org.kde.konsole-$pid $i tabTitleFormat 0)
                    PROCESSID=$(qdbus org.kde.konsole-$pid $i processId)
                    CWD=$(pwdx ${PROCESSID} | sed -e "s/^[0-9]*: //")
                    # Do not record command. Re-running a command automatically looks dangerous to me.
                    #if [[ $(pgrep --parent ${PROCESSID}) ]] ; then
                    #    CHILDPID=$(pgrep --parent ${PROCESSID})
                    #    COMMAND=$(ps -p ${CHILDPID} -o args=)
                    #fi 
                    echo "workdir: ${CWD};; title: ${FORMAT};; command:${COMMAND}" >> "${SAVE_PATH}/${pid}"
                    COMMAND=''
                done
            fi
        fi
    done <<< "$pids"
fi
