variable "tenancy_ocid" {}

variable "user_ocid" {}

variable "fingerprint" {}

variable "private_key_path" {}

variable "compartment_ocid" {
  description = "Compartment OCID"
}

variable "region" {
  description = "region Example: us-ashburn-1."
}

variable "vcn_ocid" {
  description = "The OCID VCN"
}

variable "file_system_name" {}

variable "export_path" {}

variable "subnet_ocid" {}

variable "availability_domain" {}

variable "mount_target_id" {}

variable "oracle_image_ocid" {
  description = "Example: Oracle-Linux-7.8-2020.09.23-0"
}

variable "k8s_cluster_ocid" {}

variable "node_shape" {}

variable "kubernetes_version" {}

variable "node_shape_config_ocpus" {}

variable "node_shape_config_memory_in_gbs" {}
