group "jenkins"

user "jenkins" do
  home "/var/lib/jenkins"
  supports manage_home: true
end

sudo "jenkins" do
  user "jenkins"
  group "jenkins"
  runas "ALL"
  commands ["ALL"]
  host "ALL"
  nopasswd true
end

directory "/var/lib/jenkins/.ssh" do
  owner "jenkins"
  group "jenkins"
  mode "0700"
end

cookbook_file "/var/lib/jenkins/.ssh/authorized_keys" do
  owner "jenkins"
  group "jenkins"
  mode "0644"
  source "jenkins_id_rsa.pub"
end
