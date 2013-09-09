name "jenkins"
description "Jenkins"
default_attributes({})
run_list(
  "role[benchmark]",
  "recipe[roadrunners::install_ssh_known_hosts]"
)
