::dotfiles-for-windows
::LeeJunHwan(ur0n2)

@echo off

echo [+] 바탕화면에 png, test 폴더 생성
mkdir %SYSTEMDRIVE%\linked
mkdir %USERPROFILE%\Desktop\png
mkdir %USERPROFILE%\Desktop\test

echo [+] linked 환경변수(%path%) 등록
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%Path%;%SYSTEMDRIVE%\linked;%SYSTEMDRIVE%\linked\for_intranet\lnk;%SYSTEMDRIVE%\linked\for_my\lnk;" /f

echo [+] 즐겨찾기 바로가기 복사
xcopy favorite %Userprofile%\Links /e /h /k /I /C /Y

echo [+] linked 복사 
xcopy linked %SYSTEMDRIVE%\linked /e /h /k /I /C /Y

echo [+] registry, doskey 등록 
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\putty_color_set.reg
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\Doskey_Registry.reg


echo [+] startup 등록(intranet-aal, pingpong, route, etc..) 

echo [+] 픽픽 설정
xcopy picpick %appdata%\PicPick\ /e /h /k /I /C /Y
cd %appdata%\PicPick\
call make_picpick_ini.bat

echo [+] help 모듈
::help

echo [+] shell:sendto 등록

pause
