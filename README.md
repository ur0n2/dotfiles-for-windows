# Dotfiles for Windows
- If you're computer to formatted. "dotfiles-for-windows" makes compact to you're computing environment for high working performance.
- "dotfiles-for-windows" is oriented a pure windows environment. 
- You can used to windows super key that is "Win + R"
- You can used in intranet. For example, route command, intranet auto login, messenger and etc.
- Test OS(PASS): Windows 7 Pro x64, Windows Server 2012 R2 x64, Windows 10 Pro RS2 x64
- Dotfiles-for-Windows is an alternative of Mac's Spotlight for Windows OS!


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
- Reference to the [.NET Overview](https://github.com/ur0n2/dotfiles-for-windows/blob/master/DOTNET.md).
- You can downloads .NET 4.7 and WMF 5.1 below.

### .NET 4.5.2 Download
- https://www.microsoft.com/en-us/download/details.aspx?id=42642
- [Direct Link for Win7 x64](https://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe)

### WMF 4.0 Download
- https://www.microsoft.com/en-us/download/details.aspx?id=40855
- [Direct Link for Win7 x64](https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu)


## Getting Started
- Required to powershell_ise with UAC privilege. Because, 'Powershell ISE Theme' library running on powershell_ise.(Import-Module) 
- __*Just type below command in 'Windows Run'(Win+R) window!*__

> Using git for installation.
```powershell
powershell -nop -command "start-process powershell -verb runas -argumentlist {-command IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/using-git.ps1')}"
```

> Git-less installation.
```powershell
powershell -nop -command "start-process powershell -verb runas -argumentlist {-command IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/git-less.ps1')}"
```

- [git-less.ps1](https://github.com/ur0n2/dotfiles-for-windows/blob/master/git-less.ps1) file include to why i am using the iex function in powershell.(Look at the commit history)


### Windows RUN(Win + R)

![](https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/winR.png)

- This is __*Super Key*__ in Windows.


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
dn 네이버
```

### 3. Core Dictionary
- Used to Core Dictionary
- If omissionned of argument, just clipboard contents pass to argument.
- Core-Dictionary is support to only type for enlgish.
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
tr 사과
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
- bb: Immediately __shutdown__ the system. That mean is "byebye".
- rb: Immediately __reboot__ the system. That mean is "rebye".
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

![](https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/posh_monokai.png)

- Reference to [here](http://lifeinpowershell.blogspot.kr/2014/03/powershell-ise-color-themes.html).
- Need to [ISETheme](https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e) library for cnfigurate a ISETheme. It is MS-LPL License.
- ISETheme library support to the Powershell_ISE. It can't support to the Powershell.
```powershell
Set-ExecutionPolicy ByPass -Force
#- Just press the __*F5*__(run script) key. And then, Running on __*posh_ise_set_theme.ps1*__ by setup.ps1
Set-ISETheme -ThemeName "Blackboard"
Select-ISETheme
```


### 12. Favorite Link
- Add the Favorite link.
- That is System Driver(ex: C:\), Slave Drive(ex: D:\), png and test directory.

![](https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/favorite.png)



### 13. 7Zip Setting.
- 7Zip is default compress files linking program.
- 7Zip is linking program to the below extensions.
```powershell
".7z", ".XZ", ".BZIP2", ".GZIP", ".TAR", ".ZIP", ".ARJ", ".CPIO", ".CramFS", ".EXT", ".FAT", ".GPT", ".HFS", ".IHEX", ".ISO", ".LZH", ".LZMA", ".MBR", ".NTFS", ".QCOW2", ".RAR", ".RPM", ".SquashFS", ".UDF", ".UEFI", ".WIM", ".XAR", ".Z")
```

### 14. Evernote Wrapper(https://github.com/ur0n2/Evernote-Wrapper)
- Evernote wrapper with enscript.exe :bowtie:
- More information is [here](https://github.com/ur0n2/evernote-wrapper)
----------

실행
-------------
- Windows + R

![asd](https://cloud.githubusercontent.com/assets/11265463/25363203/d38fd738-2993-11e7-93f0-66eabe9e444e.gif)

- 에버노트(evernote.exe) 실행
```
ev.py
```

- day note 노트북에 오늘 날짜의 노트 오픈(없으면 생성)
```
ev.py t
```

- 모든 노트에서 "식단"이 가장 많이 들어간 노트를 query함 
```
ev.py 식단
```

----------


### 15. Directory Tree Explanation
> tree /f %systemdrive%\linked\for_my
```
%systemdrive%\LINKED\FOR_MY
├─executable_and_ini
│  │  bb.bat: 
│  │  dc.py: 
│  │  default.ini
│  │  dn.py: 
│  │  Doskey_Alias_Setting.cmd
│  │  Doskey_Registry.reg: 
│  │  ev.py: 
│  │  Fast_PuTTY.py: 
│  │  ISEColorThemeCmdlets.ps1
│  │  pingpong.bat: 
│  │  putty_color_set.reg: 
│  │  rb.bat: 
│  │  tc.bat: 
│  │  tr.py: 
│  │  
│  └─PowershellColorThemes
│          Blackboard.StorableColorTheme.ps1xml: 
│          CoSolarized.StorableColorTheme.ps1xml: 
│          IR_Black.StorableColorTheme.ps1xml: 
│          Monokai.StorableColorTheme.ps1xml: 
│          PowerShellColorThemes
│          PowerShellColorThemes Information.txt
│          
└─lnk
        7z.lnk: 7-Zip
        bb.lnk: 
        bt.lnk: 
        c.lnk: 
        cff.lnk: CFF Explorer
        chrome.lnk: 
        ci.lnk: Chrome Incognito-Mode
        cmd.lnk: 
        cygwin.lnk: 
        d.lnk: 
        dc.lnk: 
        dd.lnk: Desktop
        dk.lnk: 
        dn.lnk: 
        ds.lnk: 
        dw.lnk: Download Directory
        edge.lnk: Edge Browser
        ep.lnk: Editplus
        ev.lnk: 
        ff.lnk: Firefox
        fiddler.lnk: Fiddler
        g.lnk: Git-Bash for Windows
        gd.lnk: Google Drive Directory
        gd_.lnk: Google Drive
        gm.lnk: GMacro
        hfs.lnk: 
        hwp.lnk: Hangle Editor
        HxD.lnk: HxD
        ida.lnk: IDA Pro
        ie.lnk: Internet Explorer
        kt.lnk: Kakao Talk
        l.lnk: Linked Directory
        linked.lnk: 
        n.lnk: 
        nd.lnk: 
        nd_.lnk: 
        npp.lnk: Notepad Plus
        nt.lnk: Notepad
        on.lnk: 
        p.lnk: Python for command
        paros_.lnk: 
        pe.lnk: 
        peid.lnk: 
        peview.lnk: 
        pipo.lnk: Ping Tester
        png.lnk: Png Directory
        pp.lnk: PicPick
        ppt.lnk: Powerpoint
        ps.lnk: Powershell run as Administrator
        psi.lnk: Powershell ISE run as Administrator
        pt.lnk: 
        putty.lnk: Putty
        pw.lnk: 
        python.lnk: Run 'Python' with cmd.exe
        rb.lnk: 
        rdp.lnk: mstsc wrap
        rs.lnk: 
        sb.lnk: Sublime Text
        scp.lnk: WinSCP
        servec.lnk: 
        served.lnk: 
        servedw.lnk: 
        ss.lnk: 
        startup.lnk: Startup directory path
        t.lnk: Trash(Recycle Bin)
        tc.lnk: Trash clean
        tcc.lnk: Trash clean and remove *.png file of png directory 
        test.lnk: 'test' directory in Desktop
        tr.lnk: 
        tv.lnk: 
        ut.lnk: 
        v.lnk: vSphere
        vb.lnk: VirtualBox
        vm.lnk: VMWare
        vol.lnk: Volmum Mixer(Controller)
        vs.lnk: Visual Studio Code
        wh.lnk: 
        ws.lnk: Wireshark
        xftp.lnk: XFTP
        xs.lnk: XShell
```


## Author
- by ur0n2(Home: [:house_with_garden:](https://ur0n2.com), Github: [:octocat:](https://github.com/ur0n2))


## License
- [MIT License](https://github.com/ur0n2/dotfiles-for-windows/blob/master/LICENSE)
