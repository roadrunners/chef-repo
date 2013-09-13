bash "clean_redis" do
  code <<-EOH
    redis-cli -n 0 flushall
    redis-cli -n 1 flushall
    redis-cli -n 2 flushall
  EOH
end
