name "base"
description "Base"
default_attributes({
  ulimit: {
    users: {
      ubuntu: {
        filehandle_limit: 999999
      }
    }
  }
})
run_list(
  "recipe[ulimit]",
  "recipe[roadrunners::setup_jenkins_user]"
)
