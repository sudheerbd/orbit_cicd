#!/bin/bash

. ./scripts/env_variables.sh

oci artifacts container image list --compartment-id ocid1.compartment.oc1..aaaaaaaaloxhapeicyyjz7nq5kuiojitb43uxitwobso7l5xq6emcmibaoiq  --repository-id  ocid1.containerrepo.oc1.ap-mumbai-1.0.idgrosnf0lwv.aaaaaaaa567jomboautlxf5fsg5djujuhsob53qggowbb7fmvrs3sk6mu3uq --region ap-mumbai-1 | grep version|sed  -e "s/\"version\"://"|sed 's/^ *//g'|sed -e 's|["'\'']||g'|awk '/ORBIT9/{print}' > ${WORKSPACE}/scripts/version.txt