call .\buildscripts\variables.bat

IF EXIST %cd%\orbitbootapp\ GOTO GITFETCH

call git clone -b %branchName% https://bitbucket.org/orbitanalytics/orbitbootapp.git
call git rev-parse HEAD > %sourceWARLocation%\reportingheadversion.txt
echo "New Build" > %main%\reporting_changes.txt
goto:eof

:GITFETCH
cd orbitbootapp
set /p reportingheadversion=<%sourceWARLocation%\reportingheadversion.txt
::git checkout -- orbit-app/orbit-web/orbit_env.properties
::git checkout -- orbit-app/orbit-web/src/main/resources/application-dev.properties
for /f %%i in ('git branch ^| grep \* ^| cut -d ' ' -f2-') do set currBranch=%%i
if not %currBranch%==%branchName% (
	call git reset --hard HEAD
	call git clean -f -d
	::call git config --unset-all remote.origin.fetch
	::call git remote set-branches --add origin %branchName%
	call git fetch
	call git checkout %branchName%
	call git pull
) else (
	call git pull
)
for /f %%i in ('git branch ^| grep \* ^| cut -d ' ' -f2-') do set currBranch=%%i
if not %currBranch%==%branchName% (
	exit /B 1
)
IF "%reportingheadversion%"=="" ( 
	echo "New Build" > %main%\reporting_changes.txt
) else (
	git log --no-merges --pretty=format:"%%h : %%an : %%s" %reportingheadversion%.. > %main%\reporting_changes.txt
)
call git rev-parse HEAD > %sourceWARLocation%\reportingheadversion.txt
call java -cp %config% GenerateBranchNames %main%\orbitbootapp %main%\bootbranches.properties
cd ..
goto:eof