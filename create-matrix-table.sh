pscale branch create octodemo initial-matrix-table
pscale shell octocat initial-matrix-table < "create table matrix (id int, environment text, line text); create index environment on matrix (environment(10));"
pscale deploy-request create octocat initial-matrix-table
pscale deploy-request diff octocat 1
 pscale deploy-request deploy octocat 1