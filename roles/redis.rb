name "redis"
description "Redis"
default_attributes({
  redisio: {
    servers: [
      { port: "6379" }
    ]
  },
  ulimit: {
    users: {
      redis: {
        filehandle_limit: 999999
      }
    }
  }
})
run_list(
  "role[base]",
  "role[benchmark]",
  "recipe[redisio::install]",
  "recipe[redisio::enable]",
  "recipe[ulimit]"
)
