resource "cloudflare_email_routing_settings" "this" {
  zone_id = data.cloudflare_zone.this.zone_id
  enabled = true
}

resource "cloudflare_email_routing_address" "this" {
  account_id = var.account_id
  email      = var.destination_email_address
}

resource "cloudflare_email_routing_catch_all" "this" {
  zone_id = data.cloudflare_zone.this.zone_id
  name    = "${var.domain}_catch_all"
  enabled = false

  matcher {
    type = "all"
  }

  # TODO: change from forward to drop; due to a bug in cloudflare provider,
  # value is currently required but gets rejected after apply for drop type
  action {
    type  = "forward"
    value = [cloudflare_email_routing_address.this.email]
  }
}

resource "cloudflare_email_routing_rule" "this" {
  for_each = toset(var.email_addresses)

  zone_id = data.cloudflare_zone.this.zone_id
  name    = each.key
  enabled = true

  matcher {
    type  = "literal"
    field = "to"
    value = each.key
  }

  action {
    type  = "forward"
    value = [cloudflare_email_routing_address.this.email]
  }
}
