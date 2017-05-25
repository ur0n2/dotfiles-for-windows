#dotfiles-for-windows
#LeeJunHwan(ur0n2)

function DFW_MAKE_DIR_AT_DESKTOP{
    Write-Output "[+] 바탕화면에 png, test, gire-repo 디렉터리 생성"
    
    New-Item $env:USERPROFILE\Desktop\png -type directory -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item $env:USERPROFILE\Desktop\test -type directory -Force -ErrorAction SilentlyContinue | Out-Null
    New-Item $env:USERPROFILE\Desktop\git-repo -type directory -Force -ErrorAction SilentlyContinue | Out-Null
}

function DFW_ENV_VAR_REGISTER{
    Write-Output "[+] linked 환경변수(%path%) 등록" 
    
    $add_path = @(($env:systemdrive + "\linked;"), ($env:systemdrive + "\linked\for_my\lnk;"), ($env:systemdrive + "\linked\for_intranet\lnk"))
    $curr_path_var = @([Environment]::GetEnvironmentVariable("Path", "Machine")) -split ";"   
    if ( [Environment]::GetEnvironmentVariable("ur0n2", "Machine") ){
        if ($curr_path_var.Trim() -contains ([Environment]::GetEnvironmentVariable("ur0n2", "Machine") -split ";")[1].Trim()) {
            Write-Output "[-] 현재 path 변수에 ur0n2[1]값 포함"
        }
        Write-Output "[-] `"ur0n2`" Environment Variable is already exist."
    }
    else{
        [Environment]::SetEnvironmentVariable("ur0n2", $add_path, "Machine")
        #[Environment]::GetEnvironmentVariable("ur0n2", "Machine")
        #[Environment]::GetEnvironmentVariable("Path", "Machine")
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("ur0n2", "Machine"), "Machine")
        #[Environment]::GetEnvironmentVariable("Path", "Machine") 
    }
}

function DFW_FAVORITE_COPY{
    Write-Output "[+] 즐겨찾기 바로가기 복사"
    
    $src = ".\favorite\*"
    $dest = "$env:userprofile\links\"

    New-Item -path $dest -type directory -force -ErrorAction SilentlyContinue  | Out-Null
    Copy-Item -path $src -destination $dest -recurse -force | Out-Null # Out-Null == -ErrorAction SilentlyContinue
}

function DFW_LINKED_COPY{
    Write-Output "[+] linked 복사"
    
    $src = ".\linked\*"
    $dest = "$env:systemdrive\linked\"

    Remove-Item -path $dest -recurse -force -ErrorAction SilentlyContinue | Out-Null
    New-Item -path $dest -type directory -force -ErrorAction SilentlyContinue  | Out-Null
    Copy-Item -path $src -destination $dest -recurse -force | Out-Null
}

function DFW_DOWNLOAD_TO_WEB{
    Write-Output "[+] 내 Github Repository, MS Technet에서 자료 다운로드"

    $url = "https://raw.githubusercontent.com/ur0n2/Fast-PuTTY/master/Fast_PuTTY.py"
    $output = $env:systemdrive + "\linked\for_my\executable_and_ini\Fast_PuTTY.py"
    Invoke-WebRequest -Uri $url -OutFile $output

    $url = "https://raw.githubusercontent.com/ur0n2/evernote-wrapper/master/ev.py"
    $output = $env:systemdrive + "\linked\for_my\executable_and_ini\ev.py"
    Invoke-WebRequest -Uri $url -OutFile $output
    
    url = "https://raw.githubusercontent.com/ur0n2/b64ff/master/b64ff.py"
    $output = $env:systemdrive + "\linked\for_my\executable_and_ini\b64ff.py"
    Invoke-WebRequest -Uri $url -OutFile $output

    #$url = "https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e/file/113950/1/ISEColorThemeCmdlets.ps1"
    #$output = $env:systemdrive + "\linked\for_my\executable_and_ini\ISEColorThemeCmdlets.ps1"
    #Invoke-WebRequest -Uri $url -OutFile $output

    #계속 늘어나면 그때 '/'로 split해서 $output+=$url[-1]로 $url을 iterator 돌리기
}

function DFW_FILE_PROTECTION_DISABLE{
    Write-Output "[+] 파일 실행시 보안경고 해제"
    
    if ($PSVersionTable.PSVersion.Major -eq 3) {
        gci $env:systemdrive\linked -Recurse | ForEach-Object{ Unblock-File $_.FullName}
        gci . -Recurse | ForEach-Object{ Unblock-File $_.FullName}
    }
    else{
        gci $env:systemdrive\linked -Recurse | foreach{ $a="echo.>" + $_.FullName + ":Zone.Identifier"; cmd /c $a} | Out-Null
        gci . -Recurse | foreach{ $a="echo.>" + $_.FullName + ":Zone.Identifier"; cmd /c $a} | Out-Null

    }
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
    
    $src = ""
    $dest = $env:appdata + "\Microsoft\Windows\Start Menu\Programs\"

    #Copy-Item -path $src -destination $dest -recurse -force
}

function DFW_PICPICK_SETTING{
    Write-Output "[+] 픽픽 설정"

    $src = ".\picpick\"
    $dest = "$env:appdata\PicPick\"
    $make_ini = $dest + "make_picpick_ini.bat"

    Copy-Item -path $src -destination $dest -recurse -force
    start $make_ini
}

Function DFW_COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER{
    Write-Output "[+] 압축파일 확장자 연결프로그램 7z으로 등록"

    $ext_reg_path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\"
    $compress_ext = @(".7z", ".XZ", ".BZIP2", ".GZIP", ".TAR", ".ZIP", ".ARJ", ".CPIO", ".CramFS", ".EXT", ".FAT", ".GPT", ".HFS", ".IHEX", ".ISO", ".LZH", ".LZMA", ".MBR", ".NTFS", ".QCOW2", ".RAR", ".RPM", ".SquashFS", ".UDF", ".UEFI", ".WIM", ".XAR", ".Z")
    $ext_reg_key = @("OpenWithProgids", "OpenWithList", "UserChoice")

    <#HKCU... tree
    -.zip(키)
      -OpenWithList(키)
        -{a:7zFM.exe}(데이터:값)
        -{MRUList:a}
      -OpenWithProgids
        -{CompressedFolder:0}
      -UserChoice
        -{Progid:Applications\7zFM.exe}
    -.7z
      ...
      ...
    #>

    #간혹 .ISO같은거 이미 사용중인지 hash생성후에 삭제(ri) 안되는거 있음. 따라서 에러를  2>$null | Out-Null 로 처리함 1,2 모두 $null로
    #무조건 확장자 연결 덮어씌우는거라서 no matter what i don't care about error.
    #혹은 함수명 2> $null 보기 안좋음

    $i=0
    $j=0
    while($i -ne ($compress_ext.Length)){ #압축관 확장자 조회
        $ext_reg_key_add_path = $ext_reg_path + $compress_ext.GetValue($i)
        if( (Test-Path $ext_reg_key_add_path) -eq $true){ #HKCU...의 최상위(ex:.zip)키가 존재한다면 삭제. (무조건 새로 생성할거임)
            ri $ext_reg_key_add_path -force -recurse 2>$null | Out-Null 
        }

        New-Item -Path $ext_reg_key_add_path 2>$null | Out-Null #해당 확장자의 최상위키를 만들어라.
        while($j -ne 3){ #최상위키 아래 3개의 하위 키가 없다면
            $ext_full_path = $ext_reg_path + $compress_ext.GetValue($i) + "\" + $ext_reg_key.GetValue($j) + "\"
            #write-output $ext_full_path
            New-Item -Path $ext_full_path 2>$null | Out-Null  #3개의 하위키를 순차대로 만들어라 이름은 아래와 같다. 이것이 Key의 Full Path이다.
        
            if($j -eq 0){ #첫번째 하위 키 OpenWithList
                New-ItemProperty -Path $ext_full_path -Name "CompressedFolder" -PropertyType Binary  2>$null | Out-Null 
            }
            elseif($j -eq 1){ #두번째 하위 키 OpenWithProgids
                New-ItemProperty -Path $ext_full_path -Name "a" -PropertyType String -Value "7zFM.exe" 2>$null | Out-Null 
                New-ItemProperty -Path $ext_full_path -Name "MRUList" -PropertyType String -Value "a" 2>$null | Out-Null 
            }
            elseif($j -eq 2){ #세번째 하위키 UserChoice
                New-ItemProperty -Path $ext_full_path -Name "Progid" -PropertyType String -Value "Applications\7zFM.exe" 2>$null | Out-Null 
            }
            $j++
        }
    $j=0
    $i++
    }
 }

function DFW_HELP_MOD{
    Write-Output "[+] Help 모듈"

    tree /f $env:systemdrive\linked 
    start-process https://github.com/ur0n2/dotfiles-for-windows/blob/master/README.md
}

function DFW_SHELL_SENDTO_REGISTER{
    Write-Output "[+] shell:sendto 등록"
}

function DFW_POSH_ISE_THEME_ADD{
    Write-Output "[+] Powershell ISE 테마 추가 및 적용. 스크립트 실행(F5) 후 Monokai 테마 자동 적용 및 다른 테마 선택 가능."
    
    $the = $env:systemdrive + ".\posh_ise_set_theme.ps1"
    #dotfiles-for-windows-master
    #dotfiles-for-windows
    powershell_ise -File $the
    start-process https://github.com/ur0n2/dotfiles-for-windows/blob/master/POSH_ISE_THEME.md
}

function DFW_EXECUTIONPOLICY_RECOVERY{
    Write-Output "[+] Powershell 실행 정책 복구"
    Set-Executionpolicy Restricted
}


function MAIN{   
    $fnlist =  @(Get-ChildItem function:DFW* | Select Name ) #DFW_ is Function prefix for UDF listing

    while($true){
        write-output "0. EXIT"
        write-output "1. ALL-SETUP"
        write-output "2. DFW_MAKE_DIR_AT_DESKTOP"
        write-output "3. DFW_ENV_VAR_REGISTER"
        Write-output "4. DFW_FAVORITE_COPY"
        write-output "5. DFW_LINKED_COPY"
        write-output "6. DFW_DOWNLOAD_TO_WEB"
        write-output "7. DFW_FILE_PROTECTION_DISABLE"
        write-output "8. DFW_REGISTRY_REGISTER"
        write-output "9. DFW_STARTUP_REGISTER"
        write-output "10. DFW_PICPICK_SETTING"
        write-output "11. DFW_COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER"
        write-output "12. DFW_HELP_MOD"
        write-output "13. DFW_SHELL_SENDTO_REGISTER"
        write-output "14. DFW_POSH_ISE_THEME_ADD"
        write-output "15. DFW_EXECUTIONPOLICY_RECOVERY"
        write-output ""

        $a = Read-Host -prompt "[+] Choise the menu"

        switch($a){
            "0" {EXIT}
            "1" {
                DFW_MAKE_DIR_AT_DESKTOP
                DFW_ENV_VAR_REGISTER
                DFW_FAVORITE_COPY
                DFW_LINKED_COPY
                DFW_DOWNLOAD_TO_WEB
                DFW_FILE_PROTECTION_DISABLE
                DFW_REGISTRY_REGISTER
                DFW_STARTUP_REGISTER
                DFW_PICPICK_SETTING
                DFW_COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER
                DFW_HELP_MOD
                DFW_SHELL_SENDTO_REGISTER
                DFW_POSH_ISE_THEME_ADD
                DFW_EXECUTIONPOLICY_RECOVERY
                }
            "2" {DFW_MAKE_DIR_AT_DESKTOP}
            "3" {DFW_ENV_VAR_REGISTER}
            "4" {DFW_FAVORITE_COPY}
            "5" {DFW_LINKED_COPY}
            "6" {DFW_DOWNLOAD_TO_WEB}
            "7" {DFW_FILE_PROTECTION_DISABLE}
            "8" {DFW_REGISTRY_REGISTER}
            "9" {DFW_STARTUP_REGISTER}
            "10" {DFW_PICPICK_SETTING}
            "11" {DFW_COMPRESS_EXTENSION_LINK_TO_7Z_REGISTER}
            "12" {DFW_HELP_MOD}
            "13" {DFW_SHELL_SENDTO_REGISTER}
            "14" {DFW_POSH_ISE_THEME_ADD}
            "15" {DFW_EXECUTIONPOLICY_RECOVERY}
            default {"`r`n`r`n[+] Re-choice`r`n"}
        }
    }
}

MAIN
