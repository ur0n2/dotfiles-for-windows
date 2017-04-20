#dotfiles-for-windows
#LeeJunHwan(ur0n2)

function MAKE_DIR_FOR_DESKTOP{
    Write-Output "[+] 바탕화면에 png, test 폴더 생성"
    New-Item $env:SYSTEMDRIVE\linked -type directory -Force
    New-Item $env:USERPROFILE\Desktop\png -type directory -Force
    New-Item $env:USERPROFILE\Desktop\test -type directory -Force
}

function ENV_VAR_REGISTER{
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

 function FAVORITE_COPY{
    Write-Output "[+] 즐겨찾기 바로가기 복사"
    Copy-Item -path .\favorite\* -destination $env:userprofile\links\ -recurse -force
}


function TOOL_DOWNLOAD_AT_GITHUB{
    $url = "https://raw.githubusercontent.com/ur0n2/Fast-PuTTY/master/Fast_PuTTY.py"
    $output = ".\linked\for_my\executable_and_ini\Fast_PuTTY.py"
    Invoke-WebRequest -Uri $url -OutFile $output

    $url = "https://raw.githubusercontent.com/ur0n2/evernote-wrapper/master/ev.py"
    $output = ".\linked\for_my\executable_and_ini\ev.py"
    Invoke-WebRequest -Uri $url -OutFile $output


}


function LINKED_COPY{
    Write-Output "[+] linked 복사 "
    Copy-Item -path .\linked\* -destination $env:systemdrive\linked\ -recurse -force
}

function REGISTRY_DOSKEY_REGISTER{
    Write-Output "[+] registry, doskey 등록"
    $arg_path = "import $env:systemdrive\linked\for_my\executable_and_ini\"
    $arg_reg = @("putty_color_set.reg", "Doskey_Registry.reg")

    Start-Process reg ($arg_path + $arg_reg[0])
    Start-Process reg ($arg_path + $arg_reg[1])
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

Function COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER{
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

function HELP_MOD{
    Write-Output "[+] help 모듈"
    #help
}

function SHELL_SENDTO_REGISTER{
    Write-Output "[+] shell:sendto 등록"
}
function FILE_PROTECTION_DISABLE{
    Write-Output "[+] 파일 실행시 보안경고 해제"
    if ($PSVersionTable.PSVersion.Major -eq 3) {
        gci $env:systemdrive\linked -Recurse | ForEach-Object{ Unblock-File $_.FullName}
    }
    else{
        gci $env:systemdrive\linked -Recurse | foreach{ $a="echo.>" + $_.FullName + ":Zone.Identifier"; cmd /c $a}
    }
}


function EXECUTIONPOLICY_RECOVERY{
    Set-Executionpolicy Restricted
}


function MAIN{
    while($true){
        write-output "1. ALL"
        write-output "2. MAKE_DIR_FOR_DESKTOP"
        write-output "3. ENV_VAR_REGISTER"
        write-output "4. FAVORITE_COPY"
        write-output "5. TOOL_DOWNLOAD_AT_GITHUB"
        write-output "6. LINKED_COPY"
        write-output "7. REGISTRY_DOSKY_REGISTER"
        write-output "8. STARTUP_REGISTER"
        write-output "9. PICPICK_SETTING"
        write-output "10. HELP_MOD"
        write-output "11. SHELL_SENDTO_REGISTER"
        write-output "12. COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER 2> $NULL"
        write-output "13. FILE_PROTECTION_DISABLE"
        write-output "14. EXECUTIONPOLICY_RECOVERY"

        $a = Read-Host -prompt "[+] Choise the menu: "

        switch($a){"1" {MAKE_DIR_FOR_DESKTOP
                ENV_VAR_REGISTER
                FAVORITE_COPY
                TOOL_DOWNLOAD_AT_GITHUB
                LINKED_COPY
                STARTUP_REGISTER
                PICPICK_SETTING
                HELP_MOD
                SHELL_SENDTO_REGISTER
                COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER 2> $NULL
                REGISTRY_DOSKEY_REGISTER
                FILE_PROTECTION_DISABLE
                EXECUTIONPOLICY_RECOVERY
                }
            "2" {MAKE_DIR_FOR_DESKTOP}
            "3" {ENV_VAR_REGISTER}
            "4" {FAVORITE_COPY}
            "5" {TOOL_DOWNLOAD_AT_GITHUB}
            "6" {LINKED_COPY}
            "7" {REGISTRY_DOSKEY_REGISTER}
            "8" {STARTUP_REGISTER}
            "9" {PICPICK_SETTING}
            "10" {HELP_MOD}
            "11" {SHELL_SENDTO_REGISTER}
            "12" {COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER 2> $NULL}
            "13" {FILE_PROTECTION_DISABLE}
            "14" {EXECUTIONPOLICY_RECOVERY}
            default {"`r`n[+] rechoice`r`n"}
        }
    }
}

MAIN