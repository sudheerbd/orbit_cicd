call .\buildscripts\variables.bat

IF EXIST %cd%\orbitextn\ GOTO GITFETCH

::call git clone -b %branchName% https://bitbucket.org/orbitanalytics/orbitextn.git
call git clone -b development_8.7 https://bitbucket.org/orbitanalytics/orbitextn.git
call git rev-parse HEAD > %orbExtnLibraryLocation%\orbitextnheadversion.txt
echo "New Build" > %main%\extn_changes.txt
goto:eof

:GITFETCH
cd %cd%\orbitextn\external_extn\netsuite_adapter
git checkout -- orbit_env.properties
cd %cd%\..\..\orbit_extn
set /p orbitextnheadversion=<%sourceWARLocation%\orbitextnheadversion.txt
git checkout -- orbit_env.properties
for /f %%i in ('git branch ^| grep \* ^| cut -d ' ' -f2-') do set currBranch=%%i
::if not %currBranch%==%branchName% (
if not %currBranch%==development_8.7 (
	call git reset --hard HEAD
	call git clean -f -d
	::call git config --unset-all remote.origin.fetch
	::call git remote set-branches --add origin %branchName%
	::call git remote set-branches --add origin master_8.7
	call git fetch
	::call git checkout %branchName%
	call git checkout development_8.7
	call git pull
) else (
	call git pull
)

IF "%orbitextnheadversion%"=="" ( 
	echo "New Build" > %main%\extn_changes.txt
) else (
	git log --no-merges --pretty=format:"%%h : %%an : %%s" %orbitextnheadversion%.. > %main%\extn_changes.txt
)

call git rev-parse HEAD > %orbExtnLibraryLocation%\orbitextnheadversion.txt
cd ..
goto:eof