#!/bin/bash

. ./scripts/env_variables.sh

oci artifacts container image list --compartment-id ocid1.compartment.oc1..aaaaaaaaf3gacoqgqxbtwhm6nm36c6npr5p3phmzqyx5t6uy5dznkhk47deq  --repository-id  ocid1.containerrepo.oc1.ap-hyderabad-1.0.idgrosnf0lwv.aaaaaaaaq55hbsbmw24evj26c5cg34enkvdut63m4qbcrnpaqkwqqe4s2jyq --region ap-hyderabad-1 | grep version|sed  -e "s/\"version\"://"|sed 's/^ *//g'|sed -e 's|["'\'']||g'|awk '/ORBIT9/{print}' > ${WORKSPACE}/scripts/version.txt