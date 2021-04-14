#!/bin/bash
. ./scripts/env_variables.sh

kubectl delete namespace ${INSTANCE_NAME}
kubectl delete pv ${INSTANCE_NAME}-volume