hosts = search(:node, "keys_ssh:* NOT name:#{node.name}")

hosts.each do |host|
  ssh_known_hosts_entry host[:fqdn]
end
