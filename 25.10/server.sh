#!/bin/bash

# --- User Permission Check ---
# Check if the current user is root (UID 0). If not, prepend 'sudo' to the command.
SUDO_PREFIX=""
if [ "$UID" -ne 0 ]; then
    SUDO_PREFIX="sudo "
    echo "Current user is not root (UID is $UID). Commands requiring elevated permissions will be run with 'sudo'."
else
    echo "Current user is root (UID 0). Commands will be run directly."
fi

${SUDO_PREFIX}apt install -y coreutils-from-gnu --allow-remove-essential coreutils-from-uutils-
