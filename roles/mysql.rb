name "mysql"
description "MySQL"
default_attributes({
  ulimit: {
    users: {
      nginx: {
        filehandle_limit: 999999
      }
    }
  }
})
run_list(
  "role[base]",
  "role[benchmark]",
  "recipe[mysql::ruby]",
  "recipe[mysql::server]",
  "recipe[ulimit]",
  "recipe[roadrunners::initialize_databases]"
)
