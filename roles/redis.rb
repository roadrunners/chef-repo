name "redis"
description "Redis"
default_attributes({
  redisio: {
    servers: [
      { port: "6379" }
    ]
  }
})
run_list(
  "role[base]",
  "role[benchmark]",
  "recipe[redisio::install]",
  "recipe[redisio::enable]"
)
