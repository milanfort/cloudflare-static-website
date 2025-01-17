resource "cloudflare_zone_settings_override" "this" {
  zone_id = data.cloudflare_zone.this.zone_id

  settings {
    tls_1_3                  = "on"
    min_tls_version          = "1.0"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    opportunistic_encryption = "on"
    ssl                      = "flexible"
  }
}
