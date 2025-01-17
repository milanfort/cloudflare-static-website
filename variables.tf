variable "account_id" {
  type        = string
  description = "The unique identifier for your Cloudflare account"
}

variable "domain" {
  type        = string
  description = "The custom domain name to be used for the website"
}

variable "project_name" {
  type        = string
  description = "The subdomain on the *.pages.dev root domain assigned to the Cloudflare Pages project"
}

variable "create_pages_redirect" {
  type        = bool
  default     = false
  description = "Indicates whether to create a redirect from the *.pages.dev root domain to the custom domain"
}

variable "email_addresses" {
  type        = list(string)
  default     = []
  description = "A list of email addresses on the custom domain that will be forwarded to the destination email address"
}

variable "destination_email_address" {
  type        = string
  default     = ""
  description = "The email address to which the configured emails will be forwarded"
}
