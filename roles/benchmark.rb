name "benchmark"
description "Benchmark Runner"
default_attributes({
  sysctl: {
    params: {
      net: {
        ipv4: {
          ip_local_port_range: "1024 65000",
          tcp_tw_reuse: "1",
          tcp_tw_recycle: "1",
          tcp_keepalive_probes: "5",
          tcp_keepalive_intvl: "15",
          tcp_window_scaling: "1",
          tcp_rmem: "4096 87380 16777216",
          tcp_wmem: "4096 65536 16777216",
          tcp_congestion_control: "cubic",
          tcp_fin_timeout: "15",
          tcp_max_syn_backlog: "20480",
          tcp_max_tw_buckets: "400000",
          tcp_no_metrics_save: "1",
          tcp_syn_retries: "2",
          tcp_synack_retries: "2",
          netfilter: {
            ip_conntrack_tcp_timeout_time_wait: "1"
          }
        },
        core: {
          netdev_max_backlog: "4096",
          somaxconn: "4096",
          rmem_default: "8388608",
          wmem_max: "16777216",
          rmem_max: "16777216"
        },
        netfilter: {
          nf_conntrack_tcp_timeout_established: "600"
        }
      },
      vm: {
        min_free_kbytes: "65536"
      }
    }
  }
})
run_list(
  "recipe[sysctl]"
)
