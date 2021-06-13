#!/bin/sh
pscale connect monalisa add-job-to-matrix-table --execute "python3 stream-pixels-ps.py --sleep-interval=250 --environment=barfoo"
