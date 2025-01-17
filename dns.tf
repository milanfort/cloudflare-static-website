resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.this.zone_id
  type    = "A"
  name    = "www"
  content = "192.0.2.1"
  proxied = true

  depends_on = [cloudflare_ruleset.www_to_root_redirect]
}

resource "cloudflare_record" "redirect_to_pages" {
  zone_id = data.cloudflare_zone.this.zone_id
  type    = "CNAME"
  name    = "@"
  content = "${var.project_name}.pages.dev"
  proxied = true

  depends_on = [cloudflare_pages_domain.this]
}
