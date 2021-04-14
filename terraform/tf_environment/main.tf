provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

module "fss" {
  source              = "../modules/file_system"
  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain
  vcn_ocid            = var.vcn_ocid
  file_system_name    = var.file_system_name
  export_path         = var.export_path
  mount_target_id     = var.mount_target_id
}

module "node-pool" {
  source                          = "../modules/node_pool"
  compartment_ocid                = var.compartment_ocid
  availability_domain             = var.availability_domain
  vcn_ocid                        = var.vcn_ocid
  file_system_name                = var.file_system_name
  subnet_ocid                     = var.subnet_ocid
  oracle_image_ocid               = var.oracle_image_ocid
  k8s_cluster_ocid                = var.k8s_cluster_ocid
  node_shape                      = var.node_shape
  kubernetes_version              = var.kubernetes_version
  node_shape_config_ocpus         = var.node_shape_config_ocpus
  node_shape_config_memory_in_gbs = var.node_shape_config_memory_in_gbs
}
