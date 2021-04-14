resource "oci_file_storage_file_system" "file_system" {
  availability_domain = var.availability_domain
  compartment_id = var.compartment_ocid
  display_name = var.customer_name
  defined_tags = {"customer.customername"=var.customer_name}
  freeform_tags = {"file_system"= var.customer_name}
}

resource "oci_file_storage_export_set" "fss_export_set" {
    mount_target_id = var.mount_target_id
    max_fs_stat_bytes = 16106119114
    max_fs_stat_files = 1000
}

resource "oci_file_storage_export" "fss_export_fs1_mt1" {
  export_set_id  = oci_file_storage_export_set.fss_export_set.id
  file_system_id = oci_file_storage_file_system.file_system.id
  path           = var.export_path

  export_options {
    source                         = "0.0.0.0/0"
    access                         = "READ_WRITE"
    identity_squash                = "NONE"
    require_privileged_source_port = false
  }
}