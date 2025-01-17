resource "cloudflare_list" "this" {
  account_id  = var.account_id
  name        = "${var.project_name}_redirects"
  description = "Redirects for ${var.domain}"
  kind        = "redirect"

  item {
    value {
      redirect {
        source_url  = "https://www.${var.domain}/"
        target_url  = "https://${var.domain}"
        status_code = 301
      }
    }
  }

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

resource "cloudflare_ruleset" "this" {
  account_id = var.account_id
  name       = "${var.project_name}_bulk_redirect_ruleset"
  kind       = "root"
  phase      = "http_request_redirect"

  rules {
    action = "redirect"
    action_parameters {
      from_list {
        name = cloudflare_list.this.name
        key  = "http.request.full_uri"
      }
    }
    expression  = "http.request.full_uri in ${"$"}${cloudflare_list.this.name}"
    description = "${var.domain}_redirects_rule"
    enabled     = true
  }
}
