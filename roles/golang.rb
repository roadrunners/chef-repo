name "golang"
description "Golang App Server"
default_attributes({
  go: {
    version: "1.1.2"
  }
})
run_list(
  "recipe[golang]"
)
