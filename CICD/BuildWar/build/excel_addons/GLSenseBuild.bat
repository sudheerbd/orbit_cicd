call .\buildscripts\variables.bat

::cd %glsenseSourceLocation%

::call msbuild OrbitGLSense.sln /p:Configuration=Release /p:Platform="Any CPU" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}


::call msbuild OrbitXLEdge.sln /p:Configuration=Release /p:Platform="Any CPU" /p:ProductVersion=1.0.0


::devenv OrbitGLSense.sln /Build "Release" /Project OrbitGLSense