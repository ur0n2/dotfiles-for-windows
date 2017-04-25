#dotfiles-for-windows
#LeeJunHwan(ur0n2)

function DFW_MAKE_DIR_AT_DESKTOP{
    Write-Output "[+] 바탕화면에 png, test 폴더 생성"
    New-Item $env:SYSTEMDRIVE\linked -type directory -Force
    New-Item $env:USERPROFILE\Desktop\png -type directory -Force
    New-Item $env:USERPROFILE\Desktop\test -type directory -Force
}

function DFW_ENV_VAR_REGISTER{
    Write-Output "[+] linked 환경변수(%path%) 등록" 
    $add_path = @(($env:systemdrive + "\linked;"), ($env:systemdrive + "\linked\for_my\lnk;"), ($env:systemdrive + "\linked\for_intranet\lnk"))
    $curr_path_var = @([Environment]::GetEnvironmentVariable("Path", "Machine")) -split ";"   
    if ( [Environment]::GetEnvironmentVariable("ur0n2", "Machine") ){
        if ($curr_path_var.Trim() -contains ([Environment]::GetEnvironmentVariable("ur0n2", "Machine") -split ";")[1].Trim()) {
            Write-Output "현재 path 변수에 ur0n2[1]값 포함"
        }
        Write-Output "`"ur0n2`" Environment Variable is already exist"
    }
    else{
        [Environment]::SetEnvironmentVariable("ur0n2", $add_path, "Machine")
        [Environment]::GetEnvironmentVariable("ur0n2", "Machine")
        [Environment]::GetEnvironmentVariable("Path", "Machine")
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("ur0n2", "Machine"), "Machine")
        [Environment]::GetEnvironmentVariable("Path", "Machine") 
    }
}

function DFW_FAVORITE_COPY{
    Write-Output "[+] 즐겨찾기 바로가기 복사"
    Copy-Item -path .\favorite\* -destination $env:userprofile\links\ -recurse -force
}

function DFW_TOOL_DOWNLOAD_AT_GITHUB{
    Write-Output "[+] 내 Github Repository에서 Tool 다운로드"
    $url = "https://raw.githubusercontent.com/ur0n2/Fast-PuTTY/master/Fast_PuTTY.py"
    $output = ".\linked\for_my\executable_and_ini\Fast_PuTTY.py"
    Invoke-WebRequest -Uri $url -OutFile $output

    $url = "https://raw.githubusercontent.com/ur0n2/evernote-wrapper/master/ev.py"
    $output = ".\linked\for_my\executable_and_ini\ev.py"
    Invoke-WebRequest -Uri $url -OutFile $output
}

function DFW_LINKED_COPY{
    Write-Output "[+] linked 복사 "
    Copy-Item -path .\linked\* -destination $env:systemdrive\linked\ -recurse -force
}

function DFW_REGISTRY_REGISTER{
    Write-Output "[+] Registry 등록"
    $arg_path = "import $env:systemdrive\linked\for_my\executable_and_ini\"
    $arg_reg = @("putty_color_set.reg", "Doskey_Registry.reg")

    Start-Process reg ($arg_path + $arg_reg[0])
    Start-Process reg ($arg_path + $arg_reg[1])
}

function DFW_STARTUP_REGISTER{
    Write-Output "[+] startup 등록(intranet-aal, pingpong, route, etc..)"
}

function DFW_PICPICK_SETTING{
    Write-Output "[+] 픽픽 설정"
    Copy-Item -path .\picpick\* -destination $env:appdata\PicPick\ -recurse -force
    cd $env:appdata\PicPick\
    start .\make_picpick_ini.bat
}

Function DFW_COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER{
    Write-Output "[+] 압축파일 확장자 연결프로그램 7z으로 등록"
    $ext_path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\"
    $compress_ext = @(".7z", ".XZ", ".BZIP2", ".GZIP", ".TAR", ".ZIP", ".ARJ", ".CAB", ".CHM", ".CPIO", ".CramFS", ".DMG", ".EXT", ".FAT", ".GPT", ".HFS", ".IHEX", ".ISO", ".LZH", ".LZMA", ".MBR", ".MSI", ".NSIS", ".NTFS", ".QCOW2", ".RAR", ".RPM", ".SquashFS", ".UDF", ".UEFI", ".VDI", ".VHD", ".VMDK", ".WIM", ".XAR", ".Z")
    $ext_key = @("OpenWithProgids", "OpenWithList", "UserChoice")

    $i = 0
    while($i -ne ($compress_ext.Length)){    
        $ext_key_add_path = $ext_path + $compress_ext.GetValue($i)
        New-Item -Path $ext_key_add_path | Out-NULL
        while($j -ne 3){
            $ext_full_path = $ext_path + $compress_ext.GetValue($i) + "\" + $ext_key.GetValue($j) + "\"
            #write-output $ext_full_path
            New-Item -Path $ext_full_path | Out-NULL
        
        
            if($j -eq 0){
                New-ItemProperty -Path $ext_full_path -Name "CompressedFolder" -PropertyType Binary | Out-NULL
            }
            elseif($j -eq 1){
                New-ItemProperty -Path $ext_full_path -Name "a" -PropertyType String -Value "7zFM.exe" | Out-NULL
                New-ItemProperty -Path $ext_full_path -Name "MRUList" -PropertyType String -Value "a" | Out-NULL
            }
            elseif($j -eq 2){
                New-ItemProperty -Path $ext_full_path -Name "Progid" -PropertyType String -Value "Applications\7zFM.exe" | Out-NULL
            }
            $j++
        }
        $j=0
        $i++
        #write-output ""
    }
}

function DFW_HELP_MOD{
    Write-Output "[+] help 모듈"
    #help
}

function DFW_SHELL_SENDTO_REGISTER{
    Write-Output "[+] shell:sendto 등록"
}

function DFW_FILE_PROTECTION_DISABLE{
    Write-Output "[+] 파일 실행시 보안경고 해제"
    if ($PSVersionTable.PSVersion.Major -eq 3) {
        gci $env:systemdrive\linked -Recurse | ForEach-Object{ Unblock-File $_.FullName}
    }
    else{
        gci $env:systemdrive\linked -Recurse | foreach{ $a="echo.>" + $_.FullName + ":Zone.Identifier"; cmd /c $a} | Out-Null
    }
}

function DFW_EXECUTIONPOLICY_RECOVERY{
    Write-Output "[+] Powershell 실행 정책 복구"
    Set-Executionpolicy Restricted
}
    
function MAIN{   
    $fnlist =  @(Get-ChildItem function:DFW* | Select Name ) #DFW_ is Function prefix for UDF listing

    while($true){
        write-output "0. Exit"
        write-output "1. ALL-Install"
        write-output "2. MAKE_DIR_AT_DESKTOP"
        write-output "3. ENV_VAR_REGISTER"
        Write-output "4. FAVORITE_COPY"
        write-output "5. TOOL_DOWNLOAD_AT_GITHUB"
        write-output "6. LINKED_COPY"
        write-output "7. REGISTRY_DOSKEY_REGISTER"
        write-output "8. STARTUP_REGISTER"
        write-output "9. PICPICK_SETTING"
        write-output "10. COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER"
        write-output "11. HELP_MOD"
        write-output "12. SHELL_SENDTO_REGISTER"
        write-output "13. FILE_PROTECTION_DISABLE"
        write-output "14. EXECUTIONPOLICY_RECOVERY"
        write-output "15. MAKE_DIR_AT_DESKTOP"
        write-output "16. REGISTRY_REGISTER"

        $a = Read-Host -prompt "[+] Choise the menu: "

        switch($a){
            "0" {exit}
            "1" {
                    DFW_MAKE_DIR_AT_DESKTOP
                    DFW_ENV_VAR_REGISTER
                    DFW_FAVORITE_COPY
                    DFW_TOOL_DOWNLOAD_AT_GITHUB
                    DFW_LINKED_COPY
                    DFW_REGISTRY_REGISTER
                    DFW_STARTUP_REGISTER
                    DFW_PICPICK_SETTING
                    DFW_COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER
                    DFW_HELP_MOD
                    DFW_SHELL_SENDTO_REGISTER
                    DFW_FILE_PROTECTION_DISABLE
                    DFW_EXECUTIONPOLICY_RECOVERY
                }
            "2" {DFW_MAKE_DIR_AT_DESKTOP}
            "3" {DFW_ENV_VAR_REGISTER}
            "4" {DFW_FAVORITE_COPY}
            "5" {DFW_TOOL_DOWNLOAD_AT_GITHUB}
            "6" {DFW_LINKED_COPY}
            "7" {DFW_REGISTRY_REGISTER}
            "8" {DFW_STARTUP_REGISTER}
            "9" {DFW_PICPICK_SETTING}
            "10" {DFW_COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER}
            "11" {DFW_HELP_MOD}
            "12" {DFW_SHELL_SENDTO_REGISTER}
            "13" {DFW_FILE_PROTECTION_DISABLE}
            "14" {DFW_EXECUTIONPOLICY_RECOVERY}
            default {"`r`n[+] rechoice`r`n"}
        }
    }
}

MAIN
