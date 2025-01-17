data "cloudflare_zone" "this" {
  account_id = var.account_id
  name       = var.domain
}
