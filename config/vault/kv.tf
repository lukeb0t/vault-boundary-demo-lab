resource "vault_mount" "infra-creds" {
  path        = "infrastructure-creds"
  type        = "kv"
  options     = { version = "2" }
  description = "Infrastructure admin credentials"
}

resource "vault_mount" "cert-archive-db_team" {
  path        = "cert-archive-db_team"
  type        = "kv"
  options     = { version = "1" }
  description = "archived certificates"
}

resource "vault_mount" "cert-archive-web_team" {
  path        = "cert-archive-web_team"
  type        = "kv"
  options     = { version = "1" }
  description = "archived certificates"
}

resource "vault_mount" "cert-archive-infrastructure_team" {
  path        = "cert-archive-infrastructure_team"
  type        = "kv"
  options     = { version = "1" }
  description = "archived certificates"
}

resource "random_pet" "pet" {
 count = 1000
  }

resource "vault_kv_secret" "database" {
  count = 1000
  path = "${vault_mount.cert-archive-db_team.path}/${random_pet.pet[count.index].id}.energy.gov"
  data_json = jsonencode(
  {
    Certificate = "${var.key}",
    Common_name = "luke.hashidemo.com",
    Issuing_CA = "${var.key}",
    CA_chain = "${var.key}",
    Private_key = "${var.key}",
    Private_key_type = "rsa",
    Issue_date = "Aug 23, 2022 04:28:31 PM",
    Expiration_date = "Aug 23, 2022 07:15:37 PM",
    Serial_number = "13:34:de:de:63:be:c6:d4:24:71:12:9d:42:ad:72:66:f1:7c:77:cc"
  }
  )
}

resource "random_pet" "pet2" {
 count = 1000
  }

resource "vault_kv_secret" "web" {
  count = 1000
  path = "${vault_mount.cert-archive-web_team.path}/${random_pet.pet2[count.index].id}.energy.gov"
  data_json = jsonencode(
  {
    Certificate = "${var.key}",
    Common_name = "luke.hashidemo.com",
    Issuing_CA = "${var.key}",
    CA_chain = "${var.key}",
    Private_key = "${var.key}",
    Private_key_type = "rsa",
    Issue_date = "Aug 23, 2022 04:28:31 PM",
    Expiration_date = "Aug 23, 2022 07:15:37 PM",
    Serial_number = "13:34:de:de:63:be:c6:d4:24:71:12:9d:42:ad:72:66:f1:7c:77:cc"
  }
  )
}

resource "random_pet" "pet3" {
 count = 1000
  }

resource "vault_kv_secret" "infra" {
  count = 1000
  path = "${vault_mount.cert-archive-infrastructure_team.path}/${random_pet.pet3[count.index].id}.energy.gov"
  data_json = jsonencode(
  {
    Certificate = "${var.key}",
    Common_name = "luke.hashidemo.com",
    Issuing_CA = "${var.key}",
    CA_chain = "${var.key}",
    Private_key = "${var.key}",
    Private_key_type = "rsa",
    Issue_date = "Aug 23, 2022 04:28:31 PM",
    Expiration_date = "Aug 23, 2022 07:15:37 PM",
    Serial_number = "13:34:de:de:63:be:c6:d4:24:71:12:9d:42:ad:72:66:f1:7c:77:cc"
  }
  )
}

variable "key" {
  default = <<EOT
  -----BEGIN CERTIFICATE-----
MIIEgTCCA2mgAwIBAgIUEzTe3mO+xtQkcRKdQq1yZvF8d8wwDQYJKoZIhvcNAQEL
BQAwRDEYMBYGA1UEChMPTXkgb3JnYW5pemF0aW9uMQ4wDAYDVQQLEwVNeSBPVTEY
MBYGA1UEAxMPSW50ZXJtZWRpYXRlIENBMB4XDTIyMDgyMzIwMjgzMVoXDTIyMDgy
MzIzMTUzN1owHTEbMBkGA1UEAxMSbHVrZS5oYXNoaWRlbW8uY29tMIICIjANBgkq
hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnj64+/i/PhnSgN8/dQohM1ZOvIxiscA1
96wS7eL88Zk+TpzlQ/feARjWik4yskODKHm5hxPBsFBhVchvZBQoMUwXqM2xDeUE
5xtnjO+YpNmv/KZVEMGjUY2kKZyx7WPixDyGjJF8gGnABQHp5747Tb2U9ZpFO5cB
XJgO+7NOaWkww6M1o3z4dlU+5bUYcbJYLutwlEauPRBi+MpVKcG9lSj3DQdtz68o
7Fc+6x13wpXpQsGDUIdFq4YUgFTA9aSwJx8pDCmuZNtZzylrDrGBp2i9hOxyJy9F
sWTib5W1IBLVH6DgPa8IjT2fn0JaaT83jTto0Gb2ldFscBNv3cTdIysqa4YKub9P
P8sYXx/ALjIEzp3D+HT/NU+MiStiSn7lgYMnFHmLj7j+LIYEuKlBI4q9xnxfnNGR
AyBxPcjwHhgV7NRBoEB3RDisw9ROLIF2yFQ1gbcVzQ9+mCHx2DmdfpywH0jkt2E2
lYRNfoUuRQ8NJrVwFSISWFJ4oltqSBLfVfWpwbuHEF7iA0z+v2LRdZADxcBya9yR
cy5tCJXTp7P3tiI0kxuZfn2nEa0KharGEdhEdBRz1nrsXf+yuRES18u4jVKsqQAc
N8mNLUjj0KFliE3oBCw/D4Rdl20Q8V7hsDO2dbw9yOMDsPekh14Zond4CCBUvfpJ
2djNOUj7/qECAwEAAaOBkTCBjjAOBgNVHQ8BAf8EBAMCA6gwHQYDVR0lBBYwFAYI
KwYBBQUHAwEGCCsGAQUFBwMCMB0GA1UdDgQWBBSiQ62HyL5McjJVfO68CNq4fIfc
fjAfBgNVHSMEGDAWgBS/k3IGrd28IUi3Z9Z/4n3fpbndRzAdBgNVHREEFjAUghJs
dWtlLmhhc2hpZGVtby5jb20wDQYJKoZIhvcNAQELBQADggEBALNcGvaM7Agfaghw
mlRSDQkSzfngn6yvhpdlaDX5qYtIdz+izOdaBTvYQxV7YlEH5IP3czNxtxs+MMot
y4iYctBf4DnStDI4koTL9GL11KXtO4mhMZr9Koq3Jwz2lsvxfKZkLu9JMwrA+s1O
dy0Uh4Tc3hc1osXOuXTNXPQ8xo8EjSqA6m0mLNeKP5fK6Q3RBEPXaXZqO4ifgHe6
G3f6eInmEtq7lRItXtlVPmCHpkpLqN33gMrXyWEe398YTSJpj+ddiZqfw4duIAFY
q6QdmzEa4Pjx6KmEat+eln8jOnQVG4+9n1MntOZiR29OE44tarBSV3Fr013lE/v+
Nc/H0xQ=
-----END CERTIFICATE-----
EOT
}


