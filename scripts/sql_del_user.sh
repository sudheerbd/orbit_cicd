#!/bin/bash
. ./scripts/env_variables.sh

sqlplus $sql_username/$sql_pwd@$sql_adw_level @${WORKSPACE}/terraform/delete_user.sql ${INSTANCE_NAME}
