name "nginx"
description "nginx"
default_attributes({
  nginx: {
    worker_processes: "auto",
    worker_connections: "999999",
    gzip: "on",
    gzip_http_version: "1.0",
    gzip_comp_level: "2"
  },
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
  "recipe[nginx]",
  "recipe[ulimit]",
  "recipe[roadrunners::configure_nginx]"
)
