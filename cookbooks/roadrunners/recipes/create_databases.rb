::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

connection = {
  host: "localhost",
  username: "root",
  password: node[:mysql][:server_root_password]
}

TYPES = [:url_shortener]
PLATFORMS = [:go, :node]

node.set_unless[:mysql][:roadrunner_password] = secure_password
node.save

# Create databases

TYPES.each do |type|
  PLATFORMS.each do |platform|
    mysql_database "#{platform}_#{type}" do
      connection connection
      action [:drop, :create]
      sql
    end
  end
end

# Create user and grant appropriate permissions

mysql_database_user "roadrunner" do
  connection connection
  password node[:mysql][:roadrunner_password]
  action :create
end

TYPES.each do |type|
  PLATFORMS.each do |platform|
    mysql_database_user "roadrunner" do
      connection connection
      password node[:mysql][:roadrunner_password]
      database_name "#{platform}_#{type}"
      host "%"
      privileges [:all]
      action :grant
    end
  end
end
