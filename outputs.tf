output "zone_id" {
  value = data.cloudflare_zone.this.zone_id
}

output "zone_name" {
  value = data.cloudflare_zone.this.name
}

output "project_id" {
  value = cloudflare_pages_project.this.id
}

output "project_name" {
  value = cloudflare_pages_project.this.name
}

output "project_domain" {
  value = cloudflare_pages_project.this.subdomain
}

output "project_domains" {
  value = cloudflare_pages_project.this.domains
}

output "email_routing" {
  value = cloudflare_email_routing_settings.this.status
}

output "email_routing_catch_all" {
  value = cloudflare_email_routing_catch_all.this.enabled
}

output "destination_email" {
  value = cloudflare_email_routing_address.this.email
}

output "destination_email_verified" {
  value = cloudflare_email_routing_address.this.verified
}
