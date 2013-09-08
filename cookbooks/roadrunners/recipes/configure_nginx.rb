app_servers = search(:node, "role:app")

template "/etc/nginx/sites-enabled/url-shortener" do
  mode "0644"
  source "nginx_url-shortener.erb"
  variables(
    backend_servers: app_servers.map { |a| a[:ec2][:local_ipv4] }
  )
end

service "nginx" do
  action :reload
end
