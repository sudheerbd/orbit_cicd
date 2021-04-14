#!/bin/bash


export BRANCH_NAME="qa1"

#export JAVA_HOME=""

#export BRANCH_NAME="qat"


export JENKINS_HOME="/u01/jenkins"
export GO_HOME="/usr/local/bin/go"
export HELM_HOME="/usr/local/bin/helm"
export MAVEN_HOME="/usr/local/bin/apache-maven-3.5.4"
export SENCHA_CMD_7_0_0="/usr/local/bin/Sencha/Cmd/7.2.0.84"
export TERRAFORM_HOME="/usr/local/bin"
export KUBECONFIG="$HOME/.kube/config"
export KUBECTL_HOME="/usr/local/bin"
export ORACLE_HOME="/usr/lib/oracle/18.3/client64"
export OCI_CLI_HOME="/usr/local/bin/oracle-cli"

export PATH=$PATH:$JENKINS_HOME:$GO_HOME/bin:$HELM_HOME:$MAVEN_HOME/bin:$SENCHA_CMD_7_0_0:$TERRAFORM_HOME:$JAVA_HOME:$KUBECONFIG:$KUBECTL_HOME:$OCI_CLI_HOME/bin

# Set environment varibale for ADW wallet file.


export TNS_ADMIN="/u01/jenkins/adw_wallet"

export PATH=$PATH:$TNS_ADMIN

# Set environment varibale for Oracle clinet to run sqlplus commands. 
export LD_LIBRARY_PATH=”$LD_LIBRARY_PATH:$ORACLE_HOME/lib:$ORACLE_HOME/bin”
export PATH=$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/lib

export jfrog_username="admin"
export jfrog_encry_pwd="AwWwRe5LUz6Q"
export jfrog_ipaddress="172.24.4.3"
export jfrog_port="8081"
export sql_username="admin"
export sql_pwd="HC8894h4hQnbjsRg"
export sql_adw_level="cicdinternal_medium"

export mount_target_ip=172.24.2.4
export cidr_file=/tmp/cidr_file.txt
export dynamic_cidr_file=/tmp/dynamic_cidr.txt



# Terraform Variables

export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaa4yd4gmtixlbnycftdtcpfunl5m3y4qdsdrpohsiayzjvk3sck63q"
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaajglzimstg26qr5f43ananodt2jksvu5pn2do5gzkmtmx565h3ywa"
export TF_VAR_fingerprint="0e:88:04:99:dd:b4:6e:8e:50:68:02:29:f1:c5:e8:80"
export TF_VAR_private_key_path="$HOME/.oci/oci_api_key.pem"
export TF_VAR_region="ap-mumbai-1"
export TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaaloxhapeicyyjz7nq5kuiojitb43uxitwobso7l5xq6emcmibaoiq"
export TF_VAR_ssh_public_key=""
export TF_VAR_ssh_private_key=""
export TF_VAR_availability_domain="kkCG:AP-MUMBAI-1-AD-1"
export TF_VAR_vcn_ocid="ocid1.vcn.oc1.ap-mumbai-1.amaaaaaajrnjtcqahpeyopyfsqmwxqbhqsdwccdurm6zaxumhvm77uxqeoea"
export TF_VAR_mount_target_id="ocid1.mounttarget.oc1.ap_mumbai_1.aaaaaa4np2ss6ltnmjxw2llqojxwiotboaww25lnmjqwsljrfvqwiljr"
export TF_VAR_oracle_image_ocid="ocid1.image.oc1.ap-mumbai-1.aaaaaaaa4phdimb5tbwcixv2bmhzogufqkuxhvuddpymkvejqsrevozizm2a"
export TF_VAR_k8s_cluster_ocid="ocid1.cluster.oc1.ap-mumbai-1.aaaaaaaaae3dszlegjstsm3ggnsdiyrzgaydmnbwmu4dqmlfmc3gizbxmzrd"
export TF_VAR_node_shape="VM.Standard.E3.Flex"
export TF_VAR_kubernetes_version="v1.18.10"
export TF_VAR_node_shape_config_ocpus="1"
export TF_VAR_node_shape_config_memory_in_gbs="8"
export TF_VAR_subnet_newbits="8"