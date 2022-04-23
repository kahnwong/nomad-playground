job "example" {
  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1

    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"

    auto_revert = false

    canary = 0
  }

  migrate {
    max_parallel = 1

    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "cache" {
    count = 1

    network {
      port "db" {
        to = 6379
      }
    }

    service {
      name = "redis-cache"
      tags = ["global", "cache"]
      port = "db"

      check {
        name     = "alive"
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }

    }

    restart {
      attempts = 2
      interval = "30m"

      delay = "15s"

      mode = "fail"
    }

    ephemeral_disk {
      size = 300
    }

 
    task "redis" {
      driver = "docker"

      config {
        image = "redis:6.2.6"

        ports = ["db"]
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }

      # The "vault" stanza instructs the Nomad client to acquire a token from
      # a HashiCorp Vault server. The Nomad servers must be configured and
      # authorized to communicate with Vault. By default, Nomad will inject
      # The token into the job via an environment variable and make the token
      # available to the "template" stanza. The Nomad client handles the renewal
      # and revocation of the Vault token.
      #
      # For more information and examples on the "vault" stanza, please see
      # the online documentation at:
      #
      #     https://www.nomadproject.io/docs/job-specification/vault
      #
      # vault {
      #   policies      = ["cdn", "frontend"]
      #   change_mode   = "signal"
      #   change_signal = "SIGHUP"
      # }

      # Controls the timeout between signalling a task it will be killed
      # and killing the task. If not set a default is used.
      # kill_timeout = "20s"
    }
  }
}
