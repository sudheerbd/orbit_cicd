resource "oci_containerengine_node_pool" "node_pool" {
  count = var.subnet_ocid == "" ? 0 : 1
  cluster_id         = var.k8s_cluster_ocid
  compartment_id     = var.compartment_ocid
  kubernetes_version = var.kubernetes_version
  name               = var.file_system_name
  node_shape         = var.node_shape
  
  initial_node_labels {
        #Optional
        key = "node-pool"
        value = var.file_system_name
  }

  node_source_details {

    image_id    = var.oracle_image_ocid
    source_type = "IMAGE"
  }

  node_shape_config {

      #Optional
      memory_in_gbs = var.node_shape_config_memory_in_gbs
      ocpus = var.node_shape_config_ocpus
  }

  node_config_details {
    placement_configs {
      availability_domain = var.availability_domain
      subnet_id = var.subnet_ocid
    }
    size = 1
  }
}
