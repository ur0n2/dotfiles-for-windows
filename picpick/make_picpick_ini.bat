@echo off
set findstr=UserDefined
set editstr=AutoSaveFolder=%USERPROFILE%\Desktop\png
if exist picpick.ini del picpick.ini
for /f %%f in (%appdata%\PicPIck\picpick_def.txt) do (
if "%findstr%" equ "%%f" (
echo %editstr% >> %appdata%\PicPIck\picpick.ini
echo AutoSaveText3=Capture %%c >>%appdata%\PicPIck\picpick.ini
) else (
echo %%f >>%appdata%\PicPIck\picpick.ini
)
)

