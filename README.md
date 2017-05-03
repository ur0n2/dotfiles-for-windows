# Dotfiles for Windows
- If you're computer to formatted. "dotfiles-for-windows" makes compact to you'r computing environment for high working performance.
- "dotfiles-for-windows" is oriented a pure windows environment. 
- You can used to windows super key that is "Win + R"
- You can used in intranet. For example, route command, intranet auto login, messenger and etc.
- ~~In fact, this setting is optimize to me.~~


## Prerequisites 
- Required to Windows 7 SP1 or later version.
- Required to Powershell 4.0(Include to WMF 4.0(Prerequisite to .NET 4.0)) or later version.
- ~~Don't worry. Support to powershel latest version auto-installing.~~
- Below code is a version check in Powershell.  
```powershell
(Get-WmiObject -class Win32_OperatingSystem).Caption #is Windows version.
$PSVersionTable.PSVersion #is Powershell version.
$PSVersionTable.CLRVersion #seems to .NET and WMF version.
```
- Reference to the .NET Overview.
- You can downloads .NET 4.7 and WMF 5.1 below.

### .NET 4.5.2 Download
- https://www.microsoft.com/en-us/download/details.aspx?id=42642
- [Direct Link for Win7 x64](https://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe)

### WMF 4.0 Download
- https://www.microsoft.com/en-us/download/details.aspx?id=40855
- [Direct Link for Win7 x64](https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu)


## Getting Started
- Required to powershell_ise with UAC privilege. Because, 'Powershell ISE Theme' library running on powershell_ise.(Import-Module) 
```powershell
powershell Start-Process powershell_ise -Verb runas 
Set-Executionpolicy ByPass -Force
git clone "https://github.com/ur0n2/dotfiles-for-windows.git" # or download ZIP at ur0n2's github.
cd ".\dotfiles-for-windows\"
.\setup_ps.ps1
```

### Windows RUN(Win + R)

![](https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/winR.png)

- This is Super Key in Windows


## Utility
### 1. PicPick Hotkey
- PickPick is capture program. png folder 
```
- Alt + 1: 영역을 지정하여 캡처
- Alt + 2: 활성화된 윈도우 캡처
- Alt + 3: 고정된 사각 영역 캡처
- Alt + 4: 픽픽 에디터 열기
- Alt + F1: 마지막 캡처 영역 반복
```


### 2. Naver Dictionary
- Used to Naver Dictionary
- If omissionned of argument, just clipboard contents pass to argument.
```
dn
dn APPLE
```

### 3. Core Dictionary
- Used to Core Dictionary
- If omissionned of argument, just clipboard contents pass to argument.
```
dc
dc compliance
```

### 4. Google Translator
- Used to Google Translator
- If omissionned of argument, just clipboard contents pass to argument.
```
tr
tr paramater pass of the clipboard contents
```

### 5. Fast Putty(https://github.com/ur0n2/Fast-Putty)
- With pretty color set and configuration set.
- If omissionned of argument, just connect to default server.
```
pt
pt -wrt 21 
```

### 6. Fast WinSCP
- like a Fast-Putty


### 7. Doskey Alias
- Doskey alias setting like a linux environment in cmd.exe
- You can get the doskey alias list that is "doskey /MACROS" command.
```
doskey ls = dir /W /P $*
doskey l = dir $*
doskey ll = dir /A /P $*
doskey cp = copy $*
doskey rm = del $*
doskey mv = move $*
doskey grep = findstr $*
doskey cat = type $*
doskey date = echo %date%
doskey ifconfig = ipconfig
doskey . = cd ..
doskey .. = cd ../..
doskey clear = cls
doskey serve = "cmd /k python -mSimpleHTTPServer"
```

### 8. bb.bat / rb.bat
- bb: Immediately shutdown the system.
- rb: Immediately reboot to system.
```
bb
rb
```

### 9. tc.bat
- Recycle Bin(Trash Clean) clear.
```
tc
```

### 10. serve\*
- 'servec' is serving 'C drive'.
- 'served' is serving 'D drive'.
- 'servedw' is serving 'Downloads' directory.
```
servec
served
servedw
```

### 11. Powershell ISE Theme
- Select-ISETheme
- MS-LPL License


### 12. 즐찾, l, 7z, ise스샷, ev 


## Author
- by ur0n2(Home: [:house_with_garden:](https://ur0n2.com), Github: [:octocat:](https://github.com/ur0n2))


## License
[MIT License](https://github.com/ur0n2/dotfiles-for-windows/blob/master/LICENSE)

## .NET Overview

### .NET Wikipedia
- https://en.wikipedia.org/wiki/.NET_Framework_version_history

### .NET GIthub Repository
- https://github.com/Microsoft/dotnet

### Announcing the .NET Framework 4.7
- https://blogs.msdn.microsoft.com/dotnet/2017/04/05/announcing-the-net-framework-4-7/

### .NET Deploy(Not to update 4.7 version not yet)
- https://msdn.microsoft.com/ko-kr/library/ee942965(v=vs.110).aspx

### .NET 4.5.2 Download
- https://www.microsoft.com/en-us/download/details.aspx?id=42642
- [Direct Link for Win7 x64](https://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe)

### .NET 4.7 Download(The latest version release, 2017. 05. 03)
- https://www.microsoft.com/en-us/download/details.aspx?id=55167
- [Direct Link for Win7 x64](https://download.microsoft.com/download/D/D/3/DD35CC25-6E9C-484B-A746-C5BE0C923290/NDP47-KB3186497-x86-x64-AllOS-ENU.exe)

### WMF(Windows Management Framework) Overview
- https://msdn.microsoft.com/ko-kr/powershell/wmf/5.1/install-configure

### WMF 4.0 Download
- https://www.microsoft.com/en-us/download/details.aspx?id=40855
- [Direct Link for Win7 x64](https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu)

### WMF 5.0 Download
- https://www.microsoft.com/en-us/download/details.aspx?id=50395

### WMF 5.1 Download(The latest version release, 2017. 05. 03)
- https://www.microsoft.com/en-us/download/details.aspx?id=54616
- [Direct Link for Win7 x64](https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win7AndW2K8R2-KB3191566-x64.zip)

### Reference
1. http://deploymentresearch.com/Research/Post/531/A-Geeks-Guide-to-install-PowerShell-5-0-for-Windows-7-using-MDT
2. https://adsecurity.org/?p=2668
3. https://cloudywindows.com/post/easing-powershell-wmf-5-1-deployment-challenges-using-the-chocolatey-package/
