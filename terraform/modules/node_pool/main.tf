data "oci_core_vcn" "vcn_id" {
  vcn_id = var.vcn_ocid
}

data "oci_core_subnets" "subnet_list" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id = data.oci_core_vcn.vcn_id.id
}

data "oci_core_nat_gateways" "nat_gateway" {
    #Required
    compartment_id = var.compartment_ocid
    vcn_id = data.oci_core_vcn.vcn_id.id
}

# For debug cidr blocks
# output "cidr_block" {
#   value = [for subnet in data.oci_core_subnets.subnet_list.subnets : subnet.cidr_block]
# }

locals {
  cidr_block_list = [for subnet in data.oci_core_subnets.subnet_list.subnets : subnet.cidr_block]
}

resource "null_resource" "cidr_file" {
  for_each = toset(local.cidr_block_list)
  provisioner "local-exec" {
    command = "echo ${each.key} >> /tmp/cidr_file.txt"
  }
}

resource "null_resource" "get_cidr_block" {
  depends_on=[null_resource.cidr_file]
  provisioner "local-exec" {
    command = "python3 ../../scripts/dynamic_cidr_block.py >> /tmp/dynamic_cidr.txt"
  }
}

data "local_file" "dynamic_cidr_file" {
    filename = "/tmp/dynamic_cidr.txt"
  depends_on = [null_resource.get_cidr_block]
}

# For debug cidr blocks
# output "cidr_output" {
#   value = data.local_file.dynamic_cidr_file.content
# }

locals {
  cidr_num=tonumber(chomp(data.local_file.dynamic_cidr_file.content))
  cidr_block = cidrsubnet(data.oci_core_vcn.vcn_id.cidr_blocks[0], tonumber(var.subnet_newbits), local.cidr_num) 
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_ocid
  display_name   = var.customer_name
  defined_tags = {"customer.customername"=var.customer_name}

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = data.oci_core_nat_gateways.nat_gateway.nat_gateways[0]["id"]
  }
}

resource "oci_core_security_list" "securitylist" {
  display_name   = var.customer_name
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_ocid
  defined_tags = {"customer.customername"=var.customer_name}

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = local.cidr_block

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = local.cidr_block

    tcp_options {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_subnet" "node_pool_subnet" {
  cidr_block = local.cidr_block
  compartment_id = var.compartment_ocid
  vcn_id = var.vcn_ocid
  display_name = var.customer_name
  dns_label = var.customer_name
  freeform_tags = {"subnet"= var.customer_name}
  defined_tags = {"customer.customername"=var.customer_name}
  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.route_table.id 
  security_list_ids = [oci_core_security_list.securitylist.id]
}

resource "oci_containerengine_node_pool" "node_pool" {
  cluster_id         = var.k8s_cluster_ocid
  compartment_id     = var.compartment_ocid
  kubernetes_version = var.kubernetes_version
  name               = var.customer_name
  node_shape         = var.node_shape
  
  initial_node_labels {
        #Optional
        key = "node-pool"
        value = var.customer_name
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
      subnet_id = oci_core_subnet.node_pool_subnet.id
    }
    size = 1
  }
}