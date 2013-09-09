name "jenkins"
description "Jenkins"
default_attributes({})
run_list(
  "role[benchmark]",
  "recipe[ssh_known_hosts]"
)
