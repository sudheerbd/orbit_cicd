variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaa4yd4gmtixlbnycftdtcpfunl5m3y4qdsdrpohsiayzjvk3sck63q"
}

variable "user_ocid" {
  default = "ocid1.user.oc1..aaaaaaaaqj6j3yqd2lkgytkibgh2o7xockm6hggbv3wl47gzfwymudxlrrna"
}

variable "fingerprint" {
  default = "8c:2f:0e:1e:36:64:aa:69:ad:f9:61:06:98:55:95:95"
}

variable "private_key_path" {
  default = "/u01/var/jenkins_home/.oci/oci_api_key.pem"
}

variable "compartment_ocid" {
  description = "Compartment OCID"
  default     = "ocid1.compartment.oc1..aaaaaaaaf3gacoqgqxbtwhm6nm36c6npr5p3phmzqyx5t6uy5dznkhk47deq"
}

variable "node_name" {}

variable "region" {
  description = "region Example: us-ashburn-1."
  default     = "ap-mumbai-1"
}

variable "vcn_ocid" {
  description = "The OCID VCN"
  default     = "ocid1.vcn.oc1.ap-mumbai-1.amaaaaaajrnjtcqarukkqetkv4jthbjgax4vnk5sgpppakrypmdv7hty56ga"
}

variable "availability_domain" {
  default = "kkCG:AP-MUMBAI-1-AD-1"
}
