# Dotfiles for Windows
- If you're computer to formatted. "dotfiles-for-windows" makes compact to you're computing environment for high working performance.
- "dotfiles-for-windows" is oriented a pure windows environment. 
- You can used to windows super key that is "Win + R"
- You can used in intranet. For example, route command, intranet auto login, messenger and etc.
- Test OS(PASS): Windows 7 Pro x64, Windows Server 2012 R2 x64, Windows 10 Pro RS2 x64


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
> Using git for installation. (In Win+R)
```powershell
powershell -noexit -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/using-git.txt')"
```

> Git-less installation. (In Win+R)
```powershell
powershell -noexit -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/git-less.txt')"
```
- [git-less.txt](https://github.com/ur0n2/dotfiles-for-windows/blob/master/git-less.txt) file include to why i am using the iex function in powershell. 


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

![](https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/posh_monokai.png)

- Reference to [here](http://lifeinpowershell.blogspot.kr/2014/03/powershell-ise-color-themes.html).
- Need to [ISETheme](https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e) library for cnfigurate a ISETheme. It is MS-LPL License.
- ISETheme library support to the Powershell_ISE. It can't support to the Powershell.
- Just press the __*F5*__(run script) key. And then, Running on __*posh_ise_set_theme.ps1*__ by setup.ps1

### 12. Favorite Link


### 13. Compress files linking program is 7z


### 14. Evernote Wrapper(https://github.com/ur0n2/Evernote-Wrapper)


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
        7z.lnk: 
        bb.lnk: 
        bt.lnk: 
        c.lnk: 
        cff.lnk: 
        chrome.lnk: 
        ci.lnk: 
        cmd.lnk: 
        cygwin.lnk: 
        d.lnk: 
        dc.lnk: 
        dd.lnk: 
        dk.lnk: 
        dn.lnk: 
        ds.lnk: 
        dw.lnk: 
        edge.lnk: 
        ep.lnk: 
        ev.lnk: 
        ff.lnk: 
        fiddler.lnk: 
        g.lnk: 
        gd.lnk: 
        gd_.lnk: 
        gm.lnk: 
        hfs.lnk: 
        hwp.lnk: 
        HxD.lnk: 
        ida.lnk: 
        ie.lnk: 
        kt.lnk: 
        l.lnk: 
        linked.lnk: 
        n.lnk: 
        nd.lnk: 
        nd_.lnk: 
        npp.lnk: 
        nt.lnk: 
        on.lnk: 
        p.lnk: 
        paros_.lnk: 
        pe.lnk: 
        peid.lnk: 
        peview.lnk: 
        pipo.lnk: 
        png.lnk: 
        pp.lnk: 
        ppt.lnk: 
        ps.lnk: 
        psi.lnk: 
        pt.lnk: 
        putty.lnk: 
        pw.lnk: 
        python.lnk: 
        rb.lnk: 
        rdp.lnk: 
        rs.lnk: 
        sb.lnk: 
        scp.lnk: 
        servec.lnk: 
        served.lnk: 
        servedw.lnk: 
        ss.lnk: 
        startup.lnk: 
        t.lnk: 
        tc.lnk: 
        tcc.lnk: 
        test.lnk: 
        tr.lnk: 
        tv.lnk: 
        ut.lnk: 
        v.lnk: 
        vb.lnk: 
        vm.lnk: 
        vol.lnk: 
        vs.lnk: 
        wh.lnk: 
        ws.lnk: 
        xftp.lnk: 
        xs.lnk: 
```


## Author
- by ur0n2(Home: [:house_with_garden:](https://ur0n2.com), Github: [:octocat:](https://github.com/ur0n2))


## License
[MIT License](https://github.com/ur0n2/dotfiles-for-windows/blob/master/LICENSE)
