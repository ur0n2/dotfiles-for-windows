#dotfiles-for-windows
#LeeJunHwan(ur0n2)

Write-Output "[+] ����ȭ�鿡 png, test ���� ����"
New-Item %SYSTEMDRIVE%\linked -type directory -Force
New-Item %USERPROFILE%\Desktop\png -type directory -Force
New-Item %USERPROFILE%\Desktop\test -type directory -Force

Write-Output "[+] linked ȯ�溯��(%path%) ���" #issue19
$curr_path = @([Environment]::GetEnvironmentVariable("Path", "Machine")) -split ";" #$curr_path = @($env:Path) -split ";"
$curr_path
if ($curr_path -contains $env:ur0n2){
    Write-Output "`"ur0n2`" Environment Variable is already exist"
}else{
    [Environment]::GetEnvironmentVariable("Path", "Machine")
    [Environment]::SetEnvironmentVariable("Path", $env:Path + $env:ur0n2, "Machine")
    [Environment]::GetEnvironmentVariable("Path", "Machine") #$env:path is current powershell session, therefore different [Environ~]::GetEnv~ and $env:path. "[Environ~]::Get" is Dependency System Environment Variables
}

Write-Output "[+] ���ã�� �ٷΰ��� ����"
Copy-Item -path .\favorite\* -destination $env:userprofile\links\ -recurse -force
#Remove-Item $env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\ -Force -Recurse


Write-Output "[+] linked ���� 
Copy-Item -path .\linked\* -destination $env:systemdrive\linked\ -recurse -force

Write-Output "[+] registry, doskey ���"
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\putty_color_set.reg
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\Doskey_Registry.reg


Write-Output "[+] startup ���(intranet-aal, pingpong, route, etc..)"

Write-Output "[+] ���� ����"
Copy-Item -path .\picpick\* -destination $env:appdata\PicPick\ -recurse -force
cd $env:appdata\PicPick\
start .\make_picpick_ini.bat

Write-Output "[+] help ���"
#help

Write-Output "[+] shell:sendto ���"

Read-Host 'Press Enter to continue��' | Out-Null
