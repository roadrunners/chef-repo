name "nginx"
description "nginx"
default_attributes({
  nginx: {
    worker_processes: "auto",
    worker_rlimit_nofile: 999999,
    worker_connections: 20000,
    gzip: "on",
    gzip_http_version: "1.0",
    gzip_comp_level: "1"
  },
  ulimit: {
    users: {
      "www-data" => {
        filehandle_limit: 999999
      }
    }
  },
  sysctl: {
    params: {
      net: {
        ipv4: {
          tcp_tw_recycle: "0"
        }
      }
    }
  }
})
run_list(
  "role[base]",
  "role[benchmark]",
  "recipe[nginx]",
  "recipe[ulimit]",
  "recipe[roadrunners::configure_nginx]",
  "recipe[sysctl]"
)
