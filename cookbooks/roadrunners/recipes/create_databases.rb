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
      action :create
    end
  end
end

# Create user and grant appropriate permissions

mysql_database_user "roadrunner" do
  connection connection
  password node[:mysql][:roadrunner_password]
  action :create

  TYPES.each do |type|
    PLATFORMS.each do |platform|
      notifies :grant, "mysql_database_user[roadrunner_#{platform}_#{type}]", :delayed
    end
  end
end

TYPES.each do |type|
  PLATFORMS.each do |platform|
    mysql_database_user "roadrunner_#{platform}_#{type}" do
      username "roadrunner"
      connection connection
      password node[:mysql][:roadrunner_password]
      database_name "#{platform}_#{type}"
      host "%"
      privileges [:all]
      action :nothing
    end
  end
end
