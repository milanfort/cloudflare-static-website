resource "cloudflare_ruleset" "www_to_root_redirect" {
  zone_id = data.cloudflare_zone.this.zone_id
  name    = "${var.project_name}_www_to_root_redirect"
  kind    = "zone"
  phase   = "http_request_dynamic_redirect"

  rules {
    action = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = "https://${var.domain}"
        }
        preserve_query_string = true
      }
    }
    expression  = "http.request.full_uri wildcard \"https://www.*\""
    description = "${var.domain}_www_to_root_redirect"
    enabled     = true
  }
}

resource "cloudflare_list" "pages_to_root_redirect" {
  count = var.create_pages_redirect ? 1 : 0

  account_id = var.account_id
  name       = "${var.project_name}_pages_to_root_redirect"
  kind       = "redirect"

  item {
    value {
      redirect {
        source_url  = "https://${var.project_name}.pages.dev/"
        target_url  = "https://${var.domain}"
        status_code = 301
      }
    }
  }
}

resource "cloudflare_ruleset" "bulk_redirects" {
  count = var.create_pages_redirect ? 1 : 0

  account_id = var.account_id
  name       = "${var.project_name}_bulk_redirect_ruleset"
  kind       = "root"
  phase      = "http_request_redirect"

  rules {
    action = "redirect"
    action_parameters {
      from_list {
        name = cloudflare_list.pages_to_root_redirect[0].name
        key  = "http.request.full_uri"
      }
    }
    expression  = "http.request.full_uri in ${"$"}${cloudflare_list.pages_to_root_redirect[0].name}"
    description = "${var.domain}_redirects_rule"
    enabled     = true
  }
}
