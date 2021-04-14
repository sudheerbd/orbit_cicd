#!/bin/bash
. ./buildscripts/variables.sh
. $main/scripts/env_variables.sh

if [ -d "./orbitreporting" ]; then
	cd orbitreporting
	if [ $(git branch | grep \* | cut -d ' ' -f2-) == $branchName ]
	then
		git pull
	 else 
		git reset --hard HEAD
		git clean -f -d
		git config --unset-all remote.origin.fetch
		git remote set-branches --add origin $branchName
		git fetch
		git checkout $branchName
		git pull
	fi
else 
	git clone -b $branchName git@bitbucket.org:orbitanalytics/orbitreporting.git
	cd orbitreporting
fi
git rev-parse HEAD > $config/reportingheadversion.txt
cd ..
