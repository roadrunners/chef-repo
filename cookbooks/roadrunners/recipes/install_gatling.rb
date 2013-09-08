include_recipe "ark"

ark "gatling" do
  url node[:gatling][:url]
  checksum node[:gatling][:checksum]
  home_dir node[:gatling][:home]
  version node[:gatling][:version]
  append_env_path true
  action :install
end

template "/etc/profile.d/gatling_home.sh" do
  mode 0755
  source "gatling_home.sh.erb"
  variables(gatling_home: node[:gatling][:home])
end

cookbook_file "#{node[:gatling][:home]}/bin/gatling.sh" do
  mode 0755
  source "gatling.sh"
end
