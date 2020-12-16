pid_file = "./pidfile"
exit_after_auth = true

auto_auth {
  method "approle" {
    config = {
      role_id_file_path = "vault/role-id"
      secret_id_file_path = "vault/secret-id"
    }
  }

  sink "file" {
    config = {
      path = "/tmp/vault-token"
    }
  }
}

template {
  contents = <<EOF
    {{ with secret "secret2/foo3" }}
    export DOCKER_LOGIN={{ .Data.usr }}
    {{ end }}
  EOF
  destination = "vault/dockerhub"
}

template {
  contents = <<EOF
    {{ with secret "secret2/foo4" }}
    export DOCKER_LOGIN={{ .Data.pwd }}
    {{ end }}
  EOF
  destination = "vault/dockerhub"
}

