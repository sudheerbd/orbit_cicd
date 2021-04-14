#!/bin/bash
. ./scripts/env_variables.sh

username=${INSTANCE_NAME}
password="${username:0:3}Orbit#1234"

# sqlplus command to create user schema in oci ADW.
sqlplus $sql_username/$sql_pwd@$sql_adw_level @${WORKSPACE}/scripts/create_user.sql $username $password
