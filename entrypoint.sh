#!/bin/bash
#set -ex

USER_ID=${LOCAL_UID:-0}
GROUP_ID=${LOCAL_GID:-0}

if [ $USER_ID -ne 0 -a $GROUP_ID -ne 0 ]; then
    # If non-zero $USER_ID and $GROUP_ID is provided, create user.
    groupadd -g $GROUP_ID user
    useradd -u $USER_ID -g $GROUP_ID -o -m user
    export HOME=/home/user

    # Execute command via gosu.
    # This avoids trouble along using su instead.
    /usr/sbin/gosu user $@
else
    # If either $USER_ID or $GROUP_ID are 0, just execute command as root.
    $@
fi

