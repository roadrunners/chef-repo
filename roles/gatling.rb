name "gatling"
description "Gatling"
default_attributes({
  scala: {
    version: "2.10.2",
    url: "http://scala-lang.org/files/archive/scala-2.10.2.tgz",
    checksum: "f693fdbc4944a40a080866593c70c14253fca2f553a0c50a26c8c52c489666a3"
  },
  gatling: {
    version: "2.0.0-M3a",
    url: "https://s3.amazonaws.com/roadrunners/downloads/gatling-charts-highcharts-2.0.0-M3a-bundle.tar.gz",
    checksum: "078cb7539648d848de0d4ce7b0a19695e796e7a2debc2baf03226139668250fa"
  }
})
run_list(
  "role[base]",
  "role[benchmark]",
  "recipe[java::openjdk]",
  "recipe[scala]",
  "recipe[roadrunners::install_gatling]"
)
