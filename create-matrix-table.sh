#!/bin/sh
pscale database create monalisa
pscale branch create monalisa initial-matrix-table
echo "create table matrix (id bigint NOT NULL AUTO_INCREMENT, environment varchar(10) NOT NULL,  lines longtext, PRIMARY KEY (id),  KEY environment (environment) )" | pscale shell monalisa initial-matrix-table
pscale deploy-request create monalisa initial-matrix-table
pscale deploy-request diff monalisa 1
pscale deploy-request deploy monalisa 1
pscale branch create monalisa add-job-to-matrix-table
echo "alter table matrix add column job text; create index job on matrix (job(10))" | pscale shell monalisa add-job-to-matrix-table
pscale deploy-request create monalisa add-job-to-matrix-table
pscale deploy-request diff monalisa 2
./


# Alternative DB table monalisa
# create table matrix (environment varchar(10), job varchar(10), lines text);
# create index job on matrix (job);
# create index environment on matrix (environment);
# exit


