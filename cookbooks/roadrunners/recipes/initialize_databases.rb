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

CREATE_QUERIES = {
  go_url_shortener: "CREATE TABLE `short_url` (`id` int(11) NOT NULL AUTO_INCREMENT, `url` text NOT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;",
  node_url_shortener: "CREATE TABLE `short_url` (`id` int(11) NOT NULL AUTO_INCREMENT, `url` text, `createdAt` datetime NOT NULL, `updatedAt` datetime NOT NULL, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
}

CLEAN_QUERIES = {
  go_url_shortener: "TRUNCATE TABLE `short_url`;",
  node_url_shortener: "TRUNCATE TABLE `short_url`;"
}

TYPES.each do |type|
  PLATFORMS.each do |platform|
    mysql_database "#{platform}_#{type}" do
      connection connection
      action :create
      notifies :query, "mysql_database[#{platform}_#{type}_schema]", :delayed
      notifies :query, "mysql_database[#{platform}_#{type}_clean]", :delayed
    end

    mysql_database "#{platform}_#{type}_schema" do
      database_name "#{platform}_#{type}"
      connection connection
      sql CREATE_QUERIES["#{platform}_#{type}".to_sym]
      action :nothing
    end

    mysql_database "#{platform}_#{type}_clean" do
      database_name "#{platform}_#{type}"
      connection connection
      sql CLEAN_QUERIES["#{platform}_#{type}".to_sym]
      action :nothing
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
