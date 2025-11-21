#!/bin/bash

# Verify X Server is XLibre
sudo head /var/log/Xorg.0.log | grep -i server

# Verify GNU coreutils in use
ls --version
