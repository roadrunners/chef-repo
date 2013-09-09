remote_file "#{Chef::Config[:file_cache_path]}/gatling-tests.deb" do
  source "https://ci.roadrunners.in/job/build-gatling-tests/lastSuccessfulBuild/artifact/gatling-tests.deb"
  mode 0644
  use_etag true
  use_last_modified true
  action :create
  notifies :remove, "dpkg_package[gatling-tests]", :delayed
  notifies :install, "dpkg_package[gatling-tests]", :delayed
end

dpkg_package "gatling-tests" do
  source "#{Chef::Config[:file_cache_path]}/gatling-tests.deb"
  action :nothing
end
