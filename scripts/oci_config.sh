#!/bin/bash
. ./scripts/env_variables.sh

if [[ -d "$HOME/.oci" ]]
then
    rm -rf $HOME/.oci
fi

mkdir -p $HOME/.oci
cat >$HOME/.oci/config <<EOL
[DEFAULT]
user=${TF_VAR_user_ocid}
fingerprint=${TF_VAR_fingerprint}
key_file=${HOME}/.oci/oci_api_key.pem
tenancy=${TF_VAR_tenancy_ocid}
region=${TF_VAR_region}
EOL

unzip -q ${WORKSPACE}/prerequisite/oci_files/oci_key.zip -d $HOME/.oci
chown -R $USER:$USER $HOME/.oci
chmod -R 755 $HOME/.oci
