name "nginx"
description "nginx"
default_attributes({
  nginx: {
    worker_processes: "auto"
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
  "recipe[ulimit]"
)
