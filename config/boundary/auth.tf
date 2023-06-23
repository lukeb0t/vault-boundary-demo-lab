resource "boundary_auth_method_oidc" "auth0" {
  count              = var.enable_oidc ? 1 : 0
  name               = "Auth0"
  description        = "OIDC provider integration for global scope"
  scope_id           = boundary_scope.global.id
  signing_algorithms = ["RS256"]
  issuer             = var.oidc_issuer
  client_id          = var.oidc_client_id
  client_secret      = var.oidc_client_secret
  callback_url       = "http://localhost:9200/v1/auth-methods/oidc:authenticate:callback"
  api_url_prefix     = "http://localhost:9200"
  claims_scopes      = ["profile"]
}

resource "boundary_auth_method_password" "core_infra" {
  name        = "core_infra_password_auth_method"
  description = "password auth method for core infrastructure scope"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_auth_method_password" "global_pass" {
  name        = "global_password_auth_method"
  description = "password auth method for global scope"
  scope_id    = boundary_scope.global.id
}