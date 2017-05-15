Set-Executionpolicy ByPass -force;
cd $env:systemdrive\;
if ( ([float]([Environment]::OSVersion.Version | % {"{0}.{1}" -f $_.Major,$_.Minor}) -ge 6) -and [int]($PSVersionTable.PSVersion.Major -ge 4) -and [int]($PSVersionTable.CLRVersion.Major -ge 4) ){write-output "[+] Version Check PASS";}else{write-output "[+] Required to above PS 4.0, above Windows 6.1 version";start-sleep -s 3;};
$dest=write-output $env:systemdrive\dotfiles-for-windows;
remove-item $dest -recurse -force -ErrorAction SilentlyContinue;
git clone https://github.com/ur0n2/dotfiles-for-windows.git;
cd .\dotfiles-for-windows\;
.\\setup.ps1 ;

#Set-Executionpolicy ByPass;cd $env:systemdrive\;if ( (([Environment]::OSVersion.Version | % {"{0}.{1}" -f $_.Major,$_.Minor}) -ge 6.1) -and ($PSVersionTable.PSVersion.Major -ge 4) -and ($PSVersionTable.CLRVersion.Major -ge 4) ){write-output "[+] Version Check PASS"}else{write-output "[+] Required to above PS 4.0, above Windows 6.1 version";start-sleep -s 3;exit;};$dest=write-output $env:systemdrive\dotfiles-for-windows;remove-item $dest -recurse -force -ErrorAction SilentlyContinue;git clone https://github.com/ur0n2/dotfiles-for-windows.git;cd .\dotfiles-for-windows\;.\\setup.ps1 ;
