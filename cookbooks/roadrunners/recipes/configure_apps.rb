mysql_servers = search(:node, "role:mysql")
redis_servers = search(:node, "role:redis")

template "/opt/go-url-shortener/src/go-url-shortener/conf/app.conf" do
  owner "roadrunner"
  group "roadrunner"
  mode 0644
  source "go-url-shortener-app.conf.erb"
  variables(
    mysql_server: mysql_servers.first,
    redis_server: redis_servers.first
  )
end

template "/opt/node-url-shortener/config/environments/production.js" do
  owner "roadrunner"
  group "roadrunner"
  mode 0644
  source "node-url-shortener-production.js.erb"
  variables(
    mysql_server: mysql_servers.first,
    redis_server: redis_servers.first
  )
end
