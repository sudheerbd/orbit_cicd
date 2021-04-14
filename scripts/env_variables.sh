#!/bin/bash

export BRANCH_NAME="master_bkp"

#export JAVA_HOME=""
export JENKINS_HOME="/u01/var/jenkins_home"
export GO_HOME="/u01/var/go"
export HELM_HOME="/usr/local/bin/helm"
export MAVEN_HOME="/usr/local/src/apache-maven-3.5.4"
export SENCHA_CMD_7_0_0="/var/lib/jenkins/bin/Sencha/Cmd/7.2.0.84"
export TERRAFORM_HOME="/usr/local/bin"
export KUBECONFIG="$HOME/.kube/config"
export KUBECTL_HOME="/usr/local/bin/kubectl"
export ORACLE_HOME="/usr/lib/oracle/18.3/client64"
export OCI_CLI_HOME="$HOME/oci"

export PATH=$PATH:$JENKINS_HOME:$GO_HOME/bin:$HELM_HOME:$MAVEN_HOME/bin:$SENCHA_CMD_7_0_0:$TERRAFORM_HOME:$JAVA_HOME:$KUBECONFIG:$KUBECTL_HOME:$OCI_CLI_HOME

# Set environment varibale for ADW wallet file.
export TNS_ADMIN="/u01/var/jenkins_home/adw_wallet"
export PATH=$PATH:$TNS_ADMIN

# Set environment varibale for Oracle clinet to run sqlplus commands. 
export LD_LIBRARY_PATH=”$LD_LIBRARY_PATH:$ORACLE_HOME/lib:$ORACLE_HOME/bin”
export PATH=$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/lib

export jfrog_username="admin"
export jfrog_encry_pwd="APAsF7BnXVgJke3QtozMwxvbPVt"
export jfrog_ipaddress="150.136.151.169"
export jfrog_port="8081"

export sql_username="admin"
export sql_pwd="Orbit123456789"
export sql_adw_level="cicdadw_medium"

export mount_target_ip=172.23.2.254


# Terraform Variables

export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaa4yd4gmtixlbnycftdtcpfunl5m3y4qdsdrpohsiayzjvk3sck63q"
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaaqj6j3yqd2lkgytkibgh2o7xockm6hggbv3wl47gzfwymudxlrrna"
export TF_VAR_fingerprint="8c:2f:0e:1e:36:64:aa:69:ad:f9:61:06:98:55:95:95"
export TF_VAR_private_key_path="$HOME/.oci/oci_api_key.pem"
export TF_VAR_region="ap-mumbai-1"
export TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaaf3gacoqgqxbtwhm6nm36c6npr5p3phmzqyx5t6uy5dznkhk47deq"
export TF_VAR_ssh_public_key=""
export TF_VAR_ssh_private_key=""
export TF_VAR_availability_domain="kkCG:AP-MUMBAI-1-AD-1"
export TF_VAR_vcn_ocid="ocid1.vcn.oc1.ap-mumbai-1.amaaaaaajrnjtcqarukkqetkv4jthbjgax4vnk5sgpppakrypmdv7hty56ga"
export TF_VAR_mount_target_id="ocid1.mounttarget.oc1.ap_mumbai_1.aaaaaa4np2sse2hqmjxw2llqojxwiotboaww25lnmjqwsljrfvqwiljr"
export TF_VAR_oracle_image_ocid="ocid1.image.oc1.ap-mumbai-1.aaaaaaaa7oaxxmtsvkk5vc53bryvxlxqn7lb5bjemkhbw5newm7oulnzquwq"
export TF_VAR_k8s_cluster_ocid="ocid1.cluster.oc1.ap-mumbai-1.aaaaaaaaae3wgndgha2diy3emu3ggnzugu3teytbmeywmm3cmc2tmolchayt"
export TF_VAR_node_shape="VM.Standard.E3.Flex"
export TF_VAR_kubernetes_version="v1.18.10"
export TF_VAR_node_shape_config_ocpus="1"
export TF_VAR_node_shape_config_memory_in_gbs="4"

