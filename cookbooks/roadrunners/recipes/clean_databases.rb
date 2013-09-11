include_recipe "roadrunners::initialize_databases"

TYPES = [:url_shortener]
PLATFORMS = [:go, :node]

ruby_block "clean_databases" do
  block do
  end
  TYPES.each do |type|
    PLATFORMS.each do |platform|
      notifies :query, "mysql_database[#{platform}_#{type}_clean]", :delayed
    end
  end
end
