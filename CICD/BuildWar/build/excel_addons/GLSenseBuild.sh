#!/bin/bash
. ./CICD/BuildWar/variables.sh
. $main/scripts/env_variables.sh

# cd %glsenseSourceLocation%

# msbuild OrbitGLSense.sln /p:Configuration=Release /p:Platform="Any CPU" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}


# msbuild OrbitXLEdge.sln /p:Configuration=Release /p:Platform="Any CPU" /p:ProductVersion=1.0.0


# devenv OrbitGLSense.sln /Build "Release" /Project OrbitGLSense