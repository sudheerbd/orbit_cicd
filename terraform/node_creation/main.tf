provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

resource "oci_core_subnet" "node_pool_subnet" {
    cidr_block = cidrsubnet(data.oci_core_vcn.vcn_id.cidr_blocks[0], 6, length(data.oci_core_subnets.subnet_id.subnets) + 1)
    compartment_id = var.compartment_ocid
    vcn_id = var.vcn_ocid
    availability_domain = var.availability_domain 
    display_name = var.node_name
    defined_tags = {"customer.customername"=var.node_name}
    route_table_id = "ocid1.routetable.oc1.ap-mumbai-1.aaaaaaaapwybldb6jngohy4dtaznv2th2okamjgbyjpwgjf75rvcrp7x3xxq" 
    security_list_ids = ["ocid1.securitylist.oc1.ap-mumbai-1.aaaaaaaasstrgzykkhxwqfgriyfp56td62na6t6gdeowrrsa7aawwhqw4gxa"]
}

resource "oci_containerengine_node_pool" "node_pool" {

  cluster_id         = "ocid1.cluster.oc1.ap-mumbai-1.aaaaaaaaaeywizjsgjtggmzygaytenlemrrggzdggezgczrqgcrtcyrzme2t"
  compartment_id     = var.compartment_ocid
  kubernetes_version = "v1.17.9"
  name               = var.node_name
  node_shape         = "VM.Standard2.2"

  node_source_details {

    image_id    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaahvzq3yhsiwotu3o4r4dkxdq4n4aehfooiwmabml4u5ckr25qbbda"
    source_type = "IMAGE"
  }

  node_config_details {
    placement_configs {
      availability_domain = var.availability_domain
      subnet_id = oci_core_subnet.node_pool_subnet.id
    }
    size = 1
  }
}

data "oci_core_vcn" "vcn_id" {
  vcn_id = var.vcn_ocid
}

data "oci_core_subnets" "subnet_id" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaf3gacoqgqxbtwhm6nm36c6npr5p3phmzqyx5t6uy5dznkhk47deq"
  vcn_id = var.vcn_ocid
}
