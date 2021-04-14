provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

data "oci_core_vcn" "vcn_id" {
  vcn_id = var.vcn_ocid
}

data "oci_core_subnets" "subnet_list" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id = var.vcn_ocid
}

# For debug cidr blocks
# output "cidr_block" {
#   value = [for s in data.oci_core_subnets.subnet_list.subnets : s.cidr_block]
# }

locals {
  cidr_block_list = [for s in data.oci_core_subnets.subnet_list.subnets : s.cidr_block]
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
  cidr_block = cidrsubnet(data.oci_core_vcn.vcn_id.cidr_blocks[0], 6, local.cidr_num)
  vcn_display_name = data.oci_core_vcn.vcn_id.display_name
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_ocid
  display_name   = var.subnet_name
  defined_tags = {"customer.customername"=var.subnet_name}

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "ocid1.internetgateway.oc1.ap-mumbai-1.aaaaaaaauvw4y5akgjrbbqhw3usygnuat4z2t4ha45zqpbr6fg2sbtfbdaga"
  }
}

resource "oci_core_security_list" "securitylist" {
  display_name   = var.subnet_name
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_ocid
  defined_tags = {"customer.customername"=var.subnet_name}

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
  display_name = var.subnet_name
  dns_label = var.subnet_name
  freeform_tags = {"subnet"= var.subnet_name}
  defined_tags = {"customer.customername"=var.subnet_name}
  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.route_table.id 
  security_list_ids = [oci_core_security_list.securitylist.id]
}

resource "local_file" "subnet_ocidfile" {
  content  = oci_core_subnet.node_pool_subnet.id
  filename =  "/tmp/subnet.txt"
}
