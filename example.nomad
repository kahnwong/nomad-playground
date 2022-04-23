job "example" {
  datacenters = ["fringe-division"]
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

  group "echo" {
    count = 1

    network {
      port "http" {
        static = 8080
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

    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo:latest"

        ports = ["http"]

        args  = [
            "-listen", ":8080",
            "-text", "Hello and welcome to 127.0.0.1 running on port 8080",
            ]
      }

      resources {
        cpu    = 250 # MHz
        memory = 64 # MB
      }
    }
  }
}
