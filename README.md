# Dotfiles for Windows
- If you're computer to formatted. "dotfiles-for-windows" makes compact to you'r computing environment for high working performance.
- "dotfiles-for-windows" is oriented a pure windows environment. 
- You can used to windows super key that is "Win + R"
- You can used in intranet. For example, route command, intranet auto login, messenger and etc.
- ~~In fact, this setting is optimize to me.~~


## Getting Started
- Required to UAC privilege.
<pre><code>powershell Start-Process powershell -Verb runas 
Set-Executionpolicy ByPass -Force
git clone https://github.com/ur0n2/dotfiles-for-windows.git
cd .\dotfiles-for-windows\
.\setup_ps.ps1
</code></pre>

### Windows RUN(Win + R)
- ![](https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/winR.gif)
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


## License
[MIT License](https://github.com/ur0n2/dotfiles-for-windows/blob/master/LICENSE)
