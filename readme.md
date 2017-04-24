**Dotfiles for Windows**
===================
* If you're computer to formatted. As then, "dotfiles for windows" makes compact to environment for your computing performance. This is oriented a pure windows environment. In addtition, I recommending Powershell or Windows Bash Shell(from Windows 10 RS1)
* You can used to windows super key that is "Win + R"
* You can used in intranet. For example, route command, intranet auto login, messenger and etc.
* Make use of anything for Portable Windows UX
* ~~In fact, this setting is optimize to me.~~

----------

## Getting Started
----------
* Required to UAC privilege.
<pre><code> > powershell Start-Process powershell -Verb runas 
> Set-Executionpolicy ByPass -Force
> git clone https://github.com/ur0n2/dotfiles-for-windows.git
> cd .\dotfiles-for-windows\
> .\setup_ps.ps1
</code></pre>

### Windows RUN(Win + R)
* This is Super Key in Windows


## Utility
----------
### PicPick Hotkey
* PickPick is capture program. png folder 
* Alt + 1: 선택 영역 
* Alt + 2
* Alt + 3
* Alt + 4
* Alt + F1

### Naver Dictionary
* Used to Naver Dictionary

### Core Dictionary
* Used to Core Dictionary

### Google Translator
* Used to Google Translator

### Fast Putty(https://github.com/ur0n2/Fast-Putty)
* With pretty color set and configuration set.

### Fast WinSCP
* like a Fast-Putty

### Doskey Alias
* Doskey alias setting like a linux environment in cmd.exe
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
```

### bb.bat / rb.bat
```
bb.bat: Immediately shutdown the system.
rb.bat: Immediately reboot to  system.
```

### tc.bat
```
tc.bat: Recycle Bin(Trash Clean) clear.
```

## License
-------------------
[MIT License](https://github.com/ur0n2/dotfiles-for-windows/blob/master/LICENSE)
