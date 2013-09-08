name "nodejs"
description "node.js App Server"
default_attributes({
  nodejs: {
    version: "0.10.18-1chl1~raring1"
  }
})
run_list(
  "recipe[roadrunners::install_nodejs]"
)
