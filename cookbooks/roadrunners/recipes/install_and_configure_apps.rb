TYPES = ["url-shortener"]
PLATFORMS = [:node, :go]

TYPES.each do |type|
  PLATFORMS.each do |platform|
    remote_file "#{Chef::Config[:file_cache_path]}/#{platform}-#{type}.deb" do
      source "https://ci.roadrunners.in/job/build-#{platform}-#{type}/lastSuccessfulBuild/artifact/#{platform}-#{type}.deb"
      mode 0644
      use_etag true
      use_last_modified true
      action :create
      notifies :remove, "dpkg_package[#{platform}-#{type}]", :delayed
      notifies :install, "dpkg_package[#{platform}-#{type}]", :delayed
    end

    dpkg_package "#{platform}-#{type}" do
      source "#{Chef::Config[:file_cache_path]}/#{platform}-#{type}.deb"
      action :nothing
    end
  end
end

mysql_server = search(:node, "role:mysql").first
redis_server = search(:node, "role:redis").first

template "/opt/go-url-shortener/src/go-url-shortener/conf/app.conf" do
  owner "roadrunner"
  group "roadrunner"
  mode 0644
  source "go-url-shortener-app.conf.erb"
  variables(
    mysql_server: mysql_server,
    redis_server: redis_server
  )
  action :nothing
  subscribes :create, "dpkg_package[go-url-shortener]", :delayed
  only_if { File.exist?("/opt/go-url-shortener/src/go-url-shortener/conf/app.conf") }
end

template "/opt/node-url-shortener/config/environments/production.js" do
  owner "roadrunner"
  group "roadrunner"
  mode 0644
  source "node-url-shortener-production.js.erb"
  variables(
    mysql_server: mysql_server,
    redis_server: redis_server
  )
  action :nothing
  subscribes :create, "dpkg_package[node-url-shortener]", :delayed
  only_if { File.exist?("/opt/node-url-shortener/config/environments/production.js") }
end
