name "gatling"
description "Gatling"
default_attributes({
  scala: {
    version: "2.10.2",
    url: "http://scala-lang.org/files/archive/scala-2.10.2.tgz",
    checksum: "f693fdbc4944a40a080866593c70c14253fca2f553a0c50a26c8c52c489666a3"
  }
})
run_list(
  "role[base]",
  "role[benchmark]",
  "recipe[java::openjdk]",
  "recipe[scala]"
)
