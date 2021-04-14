variable "compartment_ocid" {}

variable "vcn_ocid" {}

variable "availability_domain" {}

variable "customer_name" {}

variable "oracle_image_ocid" {
    description = "Example: Oracle-Linux-7.8-2020.09.23-0"
}

variable "k8s_cluster_ocid" {}

variable "node_shape" {}

variable "kubernetes_version" {}

variable "node_shape_config_ocpus" {}

variable "node_shape_config_memory_in_gbs" {}

variable "need_subnet" {}

variable "subnet_newbits" {}
