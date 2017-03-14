@echo off
set findstr=UserDefined
set editstr=AutoSaveFolder=%USERPROFILE%\Desktop\png
if exist picpick.ini del picpick.ini
for /f %%f in (picpick_def.txt) do (
if "%findstr%" equ "%%f" (
echo %editstr% >>picpick.ini
echo AutoSaveText3=Capture %%c >>picpick.ini
) else (
echo %%f >>picpick.ini
)
)

