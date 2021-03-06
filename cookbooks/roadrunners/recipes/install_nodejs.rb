apt_repository "nodejs" do
  uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
end

package "nodejs" do
  version node["nodejs"]["version"]
  options "--force-yes"
end
