variable "name" {
  type = string
  description = "Name of the CA to create"
}

variable "description" {
  type = string
  description = "Description of the CA to create"
}

variable "default_lease" {
  type = number
  description = "Default lease time"
  # 12 hours
  default = 60 * 60 * 12
}

variable "maximum_lease" {
  type = number
  description = "Maximum lease time"
  # 24 hours
  default = 60 * 60 * 24
}

variable "crl_time" {
  type = string
  description = "Time a CRL will be valid"
  default = "86400s"
}

variable "pki_aia_basepath" {
  type = string
  description = "CA and CRL public access base path"
  default = "https://vault-pki.example.org"
}