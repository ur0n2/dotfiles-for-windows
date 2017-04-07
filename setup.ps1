#dotfiles-for-windows
#LeeJunHwan(ur0n2)

function MAKE_DIR_FOR_DESKTOP{
    Write-Output "[+] ����ȭ�鿡 png, test ���� ����"
    New-Item %SYSTEMDRIVE%\linked -type directory -Force
    New-Item %USERPROFILE%\Desktop\png -type directory -Force
    New-Item %USERPROFILE%\Desktop\test -type directory -Force
}

function ENV_VAR_REGISTER{
    Write-Output "[+] linked ȯ�溯��(%path%) ���" #issue19
    $add_path = write-debug $env:systemdrive"\linked;"$env:systemdrive"\linked\for_my\lnk;"$env:systemdrive"\linked\for_intranet\lnk"
    $curr_path = @([Environment]::GetEnvironmentVariable("Path", "Machine")) -split ";" #$curr_path = @($env:Path) -split ";"    
    if ($curr_path -contains $env:ur0n2 -and $env:ur0n2 -contains $add_path){
        Write-Output "`"ur0n2`" Environment Variable is already exist"
    }else{
        
        [Environment]::SetEnvironmentVariable("ur0n2", $add_path, "Machine")
        [Environment]::GetEnvironmentVariable("ur0n2", "Machine")
        [Environment]::GetEnvironmentVariable("Path", "Machine")
        [Environment]::SetEnvironmentVariable("Path", $env:Path + $env:ur0n2, "Machine")
        [Environment]::GetEnvironmentVariable("Path", "Machine") #$env:path is current powershell session, therefore different [Environ~]::GetEnv~ and $env:path. "[Environ~]::Get" is Dependency System Environment Variables
    }
}

 function FAVORITE_COPY{
    Write-Output "[+] ���ã�� �ٷΰ��� ����"
    Copy-Item -path .\favorite\* -destination $env:userprofile\links\ -recurse -force
    #Remove-Item $env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\ -Force -Recurse
}

function LINKED_COPY{
    Write-Output "[+] linked ���� "
    Copy-Item -path .\linked\* -destination $env:systemdrive\linked\ -recurse -force
}

function REGISTRY_DOSKY_REGISTER{
    Write-Output "[+] registry, doskey ���"
    regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\putty_color_set.reg
    regedit /S %SYSTEMDRIVE%\linked\for_my\executable_and_ini\Doskey_Registry.reg
}

function STARTUP_REGISTER{
    Write-Output "[+] startup ���(intranet-aal, pingpong, route, etc..)"
}

function PICPICK_SETTING{
    Write-Output "[+] ���� ����"
    Copy-Item -path .\picpick\* -destination $env:appdata\PicPick\ -recurse -force
    cd $env:appdata\PicPick\
    start .\make_picpick_ini.bat
}

    Function COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER{
    $ext_path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\"
    $compress_ext = @(".7z", ".XZ", ".BZIP2", ".GZIP", ".TAR", ".ZIP and WIM..AR", ".ARJ", ".CAB", ".CHM", ".CPIO", ".CramFS", ".DMG", ".EXT", ".FAT", ".GPT", ".HFS", ".IHEX", ".ISO", ".LZH", ".LZMA", ".MBR", ".MSI", ".NSIS", ".NTFS", ".QCOW2", ".RAR", ".RPM", ".SquashFS", ".UDF", ".UEFI", ".VDI", ".VHD", ".VMDK", ".WIM", ".XAR", ".Z")
    $ext_key = @("OpenWithProgids", "OpenWithList", "UserChoice")

    $i = 0
    while($i -ne ($compress_ext.Length)){    
        $ext_key_add_path = $ext_path + $compress_ext.GetValue($i)
        New-Item -Path $ext_key_add_path
        while($j -ne 3){
            $ext_full_path = $ext_path + $compress_ext.GetValue($i) + "\" + $ext_key.GetValue($j) + "\"
            #write-output $ext_full_path
            New-Item -Path $ext_full_path
        
        
            if($j -eq 0){
                New-ItemProperty -Path $ext_full_path -Name "CompressedFolder" -PropertyType Binary
            }
            elseif($j -eq 1){
                New-ItemProperty -Path $ext_full_path -Name "a" -PropertyType String -Value "7zFM.exe" | Out-NUL
                New-ItemProperty -Path $ext_full_path -Name "MRUList" -PropertyType String -Value "a"
            }
            elseif($j -eq 2){
                New-ItemProperty -Path $ext_full_path -Name "Progid" -PropertyType String -Value "Applications\7zFM.exe"
            }
            $j++
        }
        $j=0
        $i++
        #write-output ""
    }
}

function HELP_MOD{
    Write-Output "[+] help ���"
    #help
}

function SHELL_SENDTO_REGISTER{
    Write-Output "[+] shell:sendto ���"
}

function EXECUTIONPOLICY_RECOVERY{
    Set-Executionpolicy Restricted
}



MAKE_DIR_FOR_DESKTOP
ENV_VAR_REGISTER
FAVORITE_COPY
LINKED_COPY
REGISTRY_DOSKY_REGISTER
STARTUP_REGISTER
PICPICK_SETTING
HELP_MOD
SHELL_SENDTO_REGISTER

Write-Output "[+] �������� Ȯ���� �������α׷� 7z���� ���"
COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER 2> $NULL
EXECUTIONPOLICY_RECOVERY

#Read-Host 'Press Enter to continue��' | Out-Null
