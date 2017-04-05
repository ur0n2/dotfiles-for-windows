#dotfiles-for-windows
#LeeJunHwan(ur0n2)

Write-Output "[+] 바탕화면에 png, test 폴더 생성"
New-Item %SYSTEMDRIVE%\linked -type directory -Force
New-Item %USERPROFILE%\Desktop\png -type directory -Force
New-Item %USERPROFILE%\Desktop\test -type directory -Force

Write-Output "[+] linked 환경변수(%path%) 등록" #issue19
$curr_path = @([Environment]::GetEnvironmentVariable("Path", "Machine")) -split ";" #$curr_path = @($env:Path) -split ";"
$curr_path
if ($curr_path -contains $env:ur0n2){
    Write-Output "`"ur0n2`" Environment Variable is already exist"
}else{
    [Environment]::GetEnvironmentVariable("Path", "Machine")
    [Environment]::SetEnvironmentVariable("Path", $env:Path + $env:ur0n2, "Machine")
    [Environment]::GetEnvironmentVariable("Path", "Machine") #$env:path is current powershell session, therefore different [Environ~]::GetEnv~ and $env:path. "[Environ~]::Get" is Dependency System Environment Variables
}

Write-Output "[+] 즐겨찾기 바로가기 복사"
Copy-Item -path .\favorite\* -destination $env:userprofile\links\ -recurse -force
#Remove-Item $env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\ -Force -Recurse


Write-Output "[+] linked 복사 
Copy-Item -path .\linked\* -destination $env:systemdrive\linked\ -recurse -force

Write-Output "[+] registry, doskey 등록"
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\putty_color_set.reg
regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\Doskey_Registry.reg


Write-Output "[+] startup 등록(intranet-aal, pingpong, route, etc..)"

Write-Output "[+] 픽픽 설정"
Copy-Item -path .\picpick\* -destination $env:appdata\PicPick\ -recurse -force
cd $env:appdata\PicPick\
start .\make_picpick_ini.bat

Write-Output "[+] help 모듈"
#help

Write-Output "[+] shell:sendto 등록"

Read-Host 'Press Enter to continue…' | Out-Null
