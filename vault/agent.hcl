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
    {{ with secret "secret2/foo" }}
    export DOCKER_LOGIN={{ .Data.usr }}
    export DOCKER_PWD={{ .Data.pwd }}
    {{ end }}
  EOF
  destination = "vault/dockerhub"
}

