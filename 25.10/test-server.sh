#!/bin/bash
docker build -t ubuntu-lionheart-server-test -f Dockerfiles/test-server.Dockerfile .
docker run --rm -v .:/tmp ubuntu-lionheart-server-test bash -c "bash /tmp/server.sh && ls --version"
