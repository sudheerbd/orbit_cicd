variable "tenancy_ocid" {}

variable "user_ocid" {}

variable "fingerprint" {}

variable "private_key_path" {}

variable "subnet_name" {}

variable "compartment_ocid" {
  description = "Compartment OCID"
}

variable "region" {
  description = "region Example: us-ashburn-1."
}

variable "vcn_ocid" {
  description = "The OCID VCN"
}

variable "availability_domain" {}