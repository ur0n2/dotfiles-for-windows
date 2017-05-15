Set-Executionpolicy ByPass -force;
cd $env:systemdrive\;
if ( ([float]([Environment]::OSVersion.Version | % {"{0}.{1}" -f $_.Major,$_.Minor}) -ge 6) -and [int]($PSVersionTable.PSVersion.Major -ge 4) -and [int]($PSVersionTable.CLRVersion.Major -ge 4) ){write-output "[+] Version Check PASS";}else{write-output "[+] Required to above PS 4.0, above Windows 6.1 version";start-sleep -s 3;};
$uri=write-output https://github.com/ur0n2/dotfiles-for-windows/archive/master.zip;
$outfile=write-output $env:systemdrive\dotfiles-for-windows-master.zip;
$src=write-output $env:systemdrive\dotfiles-for-windows-master.zip;
$dest=write-output $env:systemdrive\dotfiles-for-windows-master;
$last_dest=write-output $dest\dotfiles-for-windows-master\;
remove-item $dest -recurse -force -ErrorAction SilentlyContinue;
remove-item $outfile -recurse -force -ErrorAction SilentlyContinue;
Invoke-WebRequest -uri $uri -outfile $outfile;
Add-Type -AssemblyName System.IO.Compression.FileSystem;
[System.IO.Compression.ZipFile]::ExtractToDirectory($src, $dest);
cd $env:systemdrive\dotfiles-for-windows-master\dotfiles-for-windows-master\;
.\\setup.ps1 ;

#Set-Executionpolicy ByPass;cd $env:systemdrive\;if ( (([Environment]::OSVersion.Version | % {"{0}.{1}" -f $_.Major,$_.Minor}) -ge 6.1) -and ($PSVersionTable.PSVersion.Major -ge 4) -and ($PSVersionTable.CLRVersion.Major -ge 4) ){write-output "[+] Version Check PASS"}else{write-output "[+] Required to above PS 4.0, above Windows 6.1 version";start-sleep -s 3;exit;};$uri=write-output https://github.com/ur0n2/dotfiles-for-windows/archive/master.zip;$outfile=write-output $env:systemdrive\dotfiles-for-windows-master.zip;$src=write-output $env:systemdrive\dotfiles-for-windows-master.zip;$dest=write-output $env:systemdrive\dotfiles-for-windows-master;$last_dest=write-output $dest\dotfiles-for-windows-master\;remove-item $dest -recurse -force -ErrorAction SilentlyContinue;remove-item $outfile -recurse -force -ErrorAction SilentlyContinue;Invoke-WebRequest -uri $uri -outfile $outfile;Add-Type -AssemblyName System.IO.Compression.FileSystem;[System.IO.Compression.ZipFile]::ExtractToDirectory($src, $dest);cd $env:systemdrive\dotfiles-for-windows-master\dotfiles-for-windows-master\;.\\setup.ps1 ;

<#
#test
powershell -noexit -nop -c "start-process powershell -verb runas -argumentlist {-command winver}"

#"-ep bypass" arguments omission. because, git-less.ps1 is include that commands.
powershell -noexit -nop -c "start-process powershell -verb runas -argumentlist {-command IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/git-less.ps1')}"

#include "-ep bypass" arguments
powershell -noexit -nop -c "start-process powershell -verb runas -argumentlist {-ep bypass -command IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/git-less.ps1')}"
#>