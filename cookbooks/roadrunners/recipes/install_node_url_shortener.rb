remote_file "#{Chef::Config[:file_cache_path]}/node-url-shortener.deb" do
  source "https://ci.roadrunners.in/job/build-node-url-shortener/lastSuccessfulBuild/artifact/node-url-shortener.deb"
  mode 0644
  use_etag true
  use_last_modified true
  action :create
end

dpkg_package "node-url-shortener" do
  source "#{Chef::Config[:file_cache_path]}/node-url-shortener.deb"
  action [:purge, :install]
end
