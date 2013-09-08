redis_server = search(:node, "role:redis").first
mysql_server = search(:node, "role:mysql").first

variables =

template "/opt/go-url-shortener/src/go-url-shortener/conf/app.conf" do
  owner "roadrunner"
  group "roadrunner"
  mode 0644
  source "go-url-shortener-app.conf.erb"
  variables(
    db_host: mysql_server[:ec2][:local_ipv4],
    db_name: "go_url_shortener",
    db_username: "roadrunner",
    db_password: mysql_server[:mysql][:roadrunner_password],
    redis_host: redis_server[:ec2][:local_ipv4]
  )
end

template "/opt/node-url-shortener/config/environments/production.js" do
  owner "roadrunner"
  group "roadrunner"
  mode 0644
  source "node-url-shortener-production.js.erb"
  variables(
    db_host: mysql_server[:ec2][:local_ipv4],
    db_name: "node_url_shortener",
    db_username: "roadrunner",
    db_password: mysql_server[:mysql][:roadrunner_password],
    redis_host: redis_server[:ec2][:local_ipv4]
  )
end
