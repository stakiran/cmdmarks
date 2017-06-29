@echo off
setlocal ENABLEDELAYEDEXPANSION

set ret=0
set targetdir=invalid
set myname=cmdmark
set datafile=%~dp0%myname%_list.txt

set indent_list= 
set indent_indicator=    

if "%1"=="help" (
	echo [Usage]
	echo %~n0          : List all bookmarks.
	echo %~n0 add      : Add the current directory as bookmark.
	echo %~n0 edit     : Open the bookmark datafile with your editor.
	echo %~n0 check    : Check pathes in the datafile and alert if an error exists.
	echo %~n0 ^(NUMBER^) : Goes ^(pushd^) to the directory matched the number.
	echo %~n0 ^(QUERY^)  : Goes ^(pushd^) to the directory matched the query.
	exit /b
)

if exist %datafile% (
	rem Do Nothing.
) else (
	echo The datafile "%datafile%" do not exists, create firstly.
	copy nul %datafile%
)

if "%1"=="check" (
	set /a cnt=0
	set /a error_cnt=0
	for /F "usebackq tokens=*" %%i in (`type %datafile%`) do (
		set /a cnt=!cnt!+1
		if exist %%i (
			rem Do Nothing.
		) else (
			set /a error_cnt=!error_cnt!+1
			echo %indent_list%!cnt!: %%i
		)
	)
	echo.
	echo %indent_indicator%!error_cnt! invalid directories.
	exit /b
)
if "%1"=="edit" (
	start "" %datafile%
	exit /b
)

if "%1"=="add" (
	echo %cd% >> %datafile%
	echo Add "%cd%" as bookmark.
	exit /b
)

if "%1"=="" (
	call :print_bookmarks
	exit /b
)

call :is_numeric %1
if %ret% neq 0 (
	set targetnum=%1
	set /a cnt=0
	for /F "usebackq tokens=*" %%i in (`type %datafile%`) do (
		set /a cnt=!cnt!+1
		if "!cnt!"=="!targetnum!" (
			endlocal
			call :do_pushd %%i
			exit /b
		)
	)
	echo Not found: !targetnum!
	exit /b
)

rem Matching...
set /a cnt=0
for /F "usebackq tokens=*" %%i in (`type %datafile% ^| findstr /I %1`) do (
	set /a cnt=!cnt!+1
)
set matched_count=!cnt!
if %matched_count% equ 1 (
	for /F "usebackq tokens=*" %%i in (`type %datafile% ^| findstr /I %1`) do (
		endlocal
		call :do_pushd %%i
	)
	exit /b
)
if %matched_count% equ 0 (
	echo Not Found: %1
	exit /b
)
echo Multiple matched... Please consider your query.
set /a cnt=0
for /F "usebackq tokens=*" %%i in (`type %datafile%`) do (
	set /a cnt=!cnt!+1
	echo %indent_list%!cnt!: %%i | findstr /I %1
)
exit /b

rem ============================
rem ======== subrootins ========
rem ============================

rem You must call endlocal from the main rootin.
rem to work pushd command correctly.
:do_pushd
echo pushd %*
pushd %*
exit /b

:print_bookmarks
set /a cnt=0
for /F "usebackq tokens=*" %%i in (`type %datafile%`) do (
	set /a cnt=!cnt!+1
	echo %indent_list%!cnt!: %%i
)
echo.
echo %indent_indicator%!cnt! bookmarks.
exit /b

rem @retval 0 If it is not numeric.
:is_numeric
set "var="&for /f "delims=0123456789" %%i in ("%1") do set var=%%i
if defined var (set ret=0) else (set ret=1)
exit /b
