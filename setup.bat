::dotfiles-for-windows
::LeeJunHwan(ur0n2)

@echo off

echo [+] ����ȭ�鿡 png, test ���� ����
mkdir %SYSTEMDRIVE%\linked
mkdir %USERPROFILE%\Desktop\png
mkdir %USERPROFILE%\Desktop\test

echo [+] linked ȯ�溯��(%path%) ���
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%Path%;%SYSTEMDRIVE%\linked;%SYSTEMDRIVE%\linked\for_intranet\lnk;%SYSTEMDRIVE%\linked\for_my\lnk;" /f

echo [+] ���ã�� �ٷΰ��� ����
xcopy favorite %Userprofile%\Links /e /h /k /I /C /Y

echo [+] linked ���� 
xcopy linked %SYSTEMDRIVE%\linked /e /h /k /I /C /Y

echo [+] registry, doskey ��� 
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\putty_color_set.reg
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\Doskey_Registry.reg


echo [+] startup ���(intranet-aal, pingpong, route, etc..) 

echo [+] ���� ����
xcopy picpick %appdata%\PicPick\ /e /h /k /I /C /Y
cd %appdata%\PicPick\
call make_picpick_ini.bat

echo [+] help ���
::help

echo [+] shell:sendto ���

pause
