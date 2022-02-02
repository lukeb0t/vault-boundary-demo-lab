provider "vault" {
  address    = "http://127.0.0.1:8201"
  token      = "groot"
  token_name = "root"
}

#provider "boundary" {
#  addr             = "http://localhost:9200"
#  recovery_kms_hcl = <<EOT
#kms "aead" {
#  purpose = "recovery"
#  aead_type = "aes-gcm"
#  key = "nIRSASgoP91KmaEcg/EAaM4iAkksyB+Lkes0gzrLIRM="
#  key_id = "global_recovery"
#}
#EOT
#}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

