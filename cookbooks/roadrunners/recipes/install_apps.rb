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
