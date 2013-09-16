name "mysql"
description "MySQL"
default_attributes({
  mysql: {
    tunable: {
      key_buffer_size: "32M",
      "myisam-recover" => "FORCE,BACKUP",

      max_connections: 500,
      thread_cache_size: 50,
      table_open_cache: 2048,

      innodb_flush_method: "O_DIRECT",
      innodb_flush_log_at_trx_commit: 2,
      innodb_file_per_table: 1,
      innodb_buffer_pool_size: "3G"
    }
  },
  ulimit: {
    users: {
      mysql: {
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
