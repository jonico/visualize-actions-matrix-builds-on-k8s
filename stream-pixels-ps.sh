#!/bin/sh
pscale connect octodemo add-job-to-matrix-table --execute "python3 stream-pixels-ps.py --sleep-interval=250 --environment=barfoo"
