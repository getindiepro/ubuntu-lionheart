#!/bin/bash
docker build -t ubuntu-lionheart-desktop-test -f Dockerfiles/test-desktop.Dockerfile .
docker run --rm -v .:/tmp ubuntu-lionheart-desktop-test bash -c "bash /tmp/desktop.sh && ls --version && sudo head /var/log/Xorg.0.log | grep -i server"
