app_servers = search(:node, "role:app")

file "/etc/nginx/sites-enabled/default" do
  action :delete
  notifies :reload, "service[nginx]", :delayed
end

template "/etc/nginx/sites-enabled/url-shortener" do
  mode "0644"
  source "nginx_url-shortener.erb"
  variables(
    backend_servers: app_servers.map { |a| a[:ec2][:local_ipv4] }
  )
  notifies :reload, "service[nginx]", :delayed
end

service "nginx" do
  action :nothing
end
