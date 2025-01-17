module "static_site" {
  source       = "../."
  account_id   = "abc123"
  domain       = "example.com"
  project_name = "test123"
}
