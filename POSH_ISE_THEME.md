# Apply the Powershell-ISE Theme.
![](https://raw.githubusercontent.com/ur0n2/dotfiles-for-windows/master/posh_monokai.png)

- Reference to [here](http://lifeinpowershell.blogspot.kr/2014/03/powershell-ise-color-themes.html).
- Need to [ISETheme](https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e) library for cnfigurate a ISETheme. It is MS-LPL License.
- ISETheme library support to the Powershell_ISE. It can't support to the Powershell.
```powershell
Set-ExecutionPolicy ByPass -Force
#- Just press the __*F5*__(run script) key. And then, Running on __*posh_ise_set_theme.ps1*__ by setup.ps1
#Set-ISETheme -ThemeName "Blackboard"
Select-ISETheme
```