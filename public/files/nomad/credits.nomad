job "credits" {
  type        = "batch"
  datacenters = ["dc1"]

  task "credits" {
    driver = "docker"

    config {
      image = "alpine:3.11"
      command = "/bin/sh"
      args    = ["-c", "apk add git && cd /local/nomad && git log --format='%aN' | sed -e s/“// | LC_ALL=C.UTF-8 sort -f | uniq -c | awk '{gsub(\"[0-9]\", \"⭐\", $1); fullname = sprintf(\"%s %s\", $2, $3); printf(\"%-22s %s\\n\", fullname, $1) }'"]
    }

    artifact {
      source      = "git::https://github.com/hashicorp/nomad"
      destination = "local/nomad"
    }

    resources {
      cpu    = 500
      memory = 256

    }
  }
}
