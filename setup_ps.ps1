#dotfiles-for-windows
#LeeJunHwan(ur0n2)

function MAKE_DIR_FOR_DESKTOP{
    Write-Output "[+] 바탕화면에 png, test 폴더 생성"
    New-Item %SYSTEMDRIVE%\linked -type directory -Force
    New-Item %USERPROFILE%\Desktop\png -type directory -Force
    New-Item %USERPROFILE%\Desktop\test -type directory -Force
}

function ENV_VAR_REGISTER{
    Write-Output "[+] linked 환경변수(%path%) 등록" #issue19
    $curr_path = @([Environment]::GetEnvironmentVariable("Path", "Machine")) -split ";" #$curr_path = @($env:Path) -split ";"
    $curr_path
    if ($curr_path -contains $env:ur0n2){
        Write-Output "`"ur0n2`" Environment Variable is already exist"
    }else{
        $add_path = write-output $env:systemdrive"\linked;"$env:systemdrive"\linked\for_my\lnk;"$env:systemdrive"\linked\for_intranet\lnk"
        [Environment]::SetEnvironmentVariable("ur0n2", $add_path, "Machine")
        [Environment]::GetEnvironmentVariable("ur0n2", "Machine")
        [Environment]::GetEnvironmentVariable("Path", "Machine")
        [Environment]::SetEnvironmentVariable("Path", $env:Path + $env:ur0n2, "Machine")
        [Environment]::GetEnvironmentVariable("Path", "Machine") #$env:path is current powershell session, therefore different [Environ~]::GetEnv~ and $env:path. "[Environ~]::Get" is Dependency System Environment Variables
    }
}

 function FAVORITE_COPY{
    Write-Output "[+] 즐겨찾기 바로가기 복사"
    Copy-Item -path .\favorite\* -destination $env:userprofile\links\ -recurse -force
    #Remove-Item $env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\ -Force -Recurse
}

function LINKED_COPY{
    Write-Output "[+] linked 복사 "
    Copy-Item -path .\linked\* -destination $env:systemdrive\linked\ -recurse -force
}

function REGISTRY_DOSKY_REGISTER{
    Write-Output "[+] registry, doskey 등록"
    regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\putty_color_set.reg
    regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\Doskey_Registry.reg
}

function STARTUP_REGISTER{
    Write-Output "[+] startup 등록(intranet-aal, pingpong, route, etc..)"
}

function PICPICK_SETTING{
    Write-Output "[+] 픽픽 설정"
    Copy-Item -path .\picpick\* -destination $env:appdata\PicPick\ -recurse -force
    cd $env:appdata\PicPick\
    start .\make_picpick_ini.bat
}

function HELP_MOD{
    Write-Output "[+] help 모듈"
    #help
}

function SHELL_SENDTO_REGISTER{
    Write-Output "[+] shell:sendto 등록"
}

ENV_VAR_REGISTER
<#
MAKE_DIR_FOR_DESKTOP
ENV_VAR_REGISTER
FAVORITE_COPY
LINKED_COPY
REGISTRY_DOSKY_REGISTER
STARTUP_REGISTER
PICPICK_SETTING
HELP_MOD
SHELL_SENDTO_REGISTER
#>

Read-Host 'Press Enter to continue…' | Out-Null
