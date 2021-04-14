#!/bin/bash

git add ../CICD/CreateInstance/Jenkinsfile
git commit -m "validation check"
git push origin $BRANCH_NAME
