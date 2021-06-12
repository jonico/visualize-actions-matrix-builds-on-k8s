#!/bin/sh
pscale database create octodemo
pscale branch create octodemo initial-matrix-table
echo "create table matrix (id int, environment text, lines text); create index environment on matrix (environment(10)); exit;" | pscale shell octodemo initial-matrix-table
pscale deploy-request create octodemo initial-matrix-table
pscale deploy-request diff octodemo 1
pscale deploy-request deploy octodemo 1
pscale branch create octodemo add-job-to-matrix-table
echo "alter table matrix add column job text; create index job on matrix (job(10)); exit;" | pscale shell octodemo add-job-to-matrix-table
pscale deploy-request create octodemo add-job-to-matrix-table
pscale deploy-request diff octodemo 2
pscale deploy-request deploy octodemo 2
