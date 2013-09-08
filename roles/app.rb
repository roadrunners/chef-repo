name "app"
description "Application Server"
default_attributes({
  ulimit: {
    users: {
      roadrunner: {
        filehandle_limit: 999999
      }
    }
  }
})
run_list(
  "role[base]",
  "role[benchmark]",
  "role[golang]",
  "role[nodejs]",
  "recipe[roadrunners::create_app_user]",
  "recipe[ulimit]",
  "recipe[roadrunners::install_apps]",
  "recipe[roadrunners::configure_apps]"
)
