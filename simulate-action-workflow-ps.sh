#!/bin/sh
act workflow_dispatch \
    -P octodemo=ghcr.io/jonico/actions-runner:ps  \
    -e events-nektos-ps.json -W .github/workflows/visualize-matrix-build-nektos-ps.yml  \
    -s PLANETSCALE_SERVICE_TOKEN_NAME=$PLANETSCALE_SERVICE_TOKEN_NAME \
    -s PLANETSCALE_SERVICE_TOKEN=$PLANETSCALE_SERVICE_TOKEN \
    -b
