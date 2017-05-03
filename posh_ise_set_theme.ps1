$module = $env:systemdrive + "\linked\for_my\executable_and_ini\ISEColorThemeCmdlets.ps1"
. $module #Equal to Import-Module $module
Import-Module $module

New-Item -Path "HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes" -Force -ErrorAction SilentlyContinue #ISEColorHtemeCmdlets.ps1 bug.. upgrade ps2.0 to ps4.0 environment -> "

$ThemeList = Get-ChildItem -Path $env:systemdrive\linked\for_my\executable_and_ini -Recurse -File -Include *.ps1xml 
$ThemeList | Import-ISEThemeFile 

Set-ISETheme -ThemeName "Monokai"
Select-ISETheme