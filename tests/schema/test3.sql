
# Name your project! Project names should contain only lowercase characters
# and underscores. A good package name should reflect your organization's
# name or the intended use of these models
name: 'sakila_dbt_project'
version: '1.0.0'
config-version: 2

vars:
 cust_id: 10
# This setting configures which "profile" dbt uses for this project.
profile: 'sakila_conn'

# These configurations specify where dbt should look for different types of files.
# The `source-paths` config, for example, states that models in this project can be
# found in the "models/" directory. You probably won't need to change these!
source-paths: ["models"]
analysis-paths: ["analysis"]
test-paths: ["tests"]
data-paths: ["data"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target"  # directory which will store compiled SQL files
clean-targets:         # directories to be removed by `dbt clean`
    - "target"
    - "dbt_modules"

on-run-start: create table if not exists dwh.dbt_log  (dbt_id varchar,start_at timestamp,end_at timestamp,status varchar,dbt_total_sec int)
on-run-end: "{{delete_from_table('my_first_dbt_model')}}"

# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

# In this example config, we tell dbt to build all models in the example/ directory
# as tables. These settings can be overridden in the individual model files
# using the `{{ config(...) }}` macro.
models:

  sakila_dbt_project:
      # Applies to all files under models/example/
      example:
          materialized: table
          +schema: examples

      dimensions:
          materialized: table
          +schema: dwh

      facts:
      materialized: table
      +schema: dwh
 