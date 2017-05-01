﻿<#
 ===============================================================================
 ===============================================================================
 Script    : ISEColorThemeCmdlets.ps1
 Date      : 3/18/2014 
 Author    : Jeff Pollock
 Blog      : http://lifeinpowershell.blogspot.com/
 Source    : Microsoft Technet Gallery: http://goo.gl/nmwkox

 Description :  A collection of Powershell cmdlets that expand the PowerShell
                ISE themeing capability to the command line. These cmdlets allow
                you to import, remove, and apply native xml and registry based 
                ISE themes without the need to format and translate the xml ARGB
                values to hex for use in a specific theme script.

 Cmdlets :  Get-FileName()
            Get-SaveFile()
            Convert-HexToARGB()
            Convert-ARGBToHex()
            Get-CurrentISETheme()
            Get-ISETheme()
            Get-ImportedISEThemes()
            Set-ISETheme()
            Import-ISEThemeFile()
            Export-ISEThemeFile()
            Remove-ISETheme()
            Set-ISEColor()
            Select-ISETheme()
            Add-ISEThemeMenu()
 ===============================================================================
 ===============================================================================
#>



#-----------------------------
#--  Get-FileName
#-----------------------------
Function Get-FileName {   
    [cmdletbinding()]
    Param(
        [parameter()]
        [string]$initialDirectory = ".\"
    )
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.ps1xml"
    $OpenFileDialog.ShowDialog() | Out-Null

    If ($OpenFileDialog.filename) {
        $OpenFileDialog.filename
    }
    <#
		.SYNOPSIS
			Gets a filename

		.DESCRIPTION
			Gets a filename using an OpenFileDialog. Does not return an filename if the dialog is canceled

		.PARAMETER initialDirectory
			The directory for the OpenFileDialog to start in. 
		
		.EXAMPLE
			PS C:\> $File = Get-FileName
            
            Assigns selected file to the 'File' variable.

        .EXAMPLE
			PS C:\> Get-FileName | Set-ISETheme

            Pipes selected filename to the Set-ISETheme cmdlet.

		.INPUTS
			System.String

		.OUTPUTS
			System.String

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Get-FileName

#-----------------------------
#--  Get-SaveFile
#-----------------------------
Function Get-SaveFile {
    [cmdletbinding()]
    Param(
        [parameter()]
        [string]$initialDirectory = ".\"
    )

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |  Out-Null

    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.initialDirectory = $initialDirectory
    $SaveFileDialog.filter = "All files (*.*)| *.StorableColorTheme.ps1xml"
    $SaveFileDialog.ShowDialog() | Out-Null

   If ($SaveFileDialog.filename) {
        $SaveFileDialog.filename
    }
    <#
		.SYNOPSIS
			Sets a file save name

		.DESCRIPTION
			Sets a file save name using an SaveFileDialog. Does not return an filename if the dialog is canceled

		.PARAMETER initialDirectory
			The directory for the OpenFileDialog to start in. 
		
		.EXAMPLE
			PS C:\> $File = Get-SaveFile
            
            Assigns selected save file to the 'File' variable.

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Get-FileName

#-----------------------------
#--  Convert-HexToARGB
#-----------------------------
Function Convert-HexToARGB {
    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$True)]
        [string]$Hex_Val
    )

    Begin{}

    Process {
        #-Convert values
        $A = [Convert]::ToInt32($Hex_Val.substring(1, 2), 16)
        $R = [Convert]::ToInt32($Hex_Val.substring(3, 2), 16)
        $G = [Convert]::ToInt32($Hex_Val.substring(5, 2), 16)
        $B = [Convert]::ToInt32($Hex_Val.substring(7, 2), 16)
        
        #-Output value object        
        $Obj = New-Object -Type PSObject
        $Obj | Add-Member -MemberType NoteProperty -Name A –Value $A
        $Obj | Add-Member -MemberType NoteProperty -Name R –Value $R
        $Obj | Add-Member -MemberType NoteProperty -Name G –Value $G
        $Obj | Add-Member -MemberType NoteProperty -Name B –Value $B
        $Obj       
    }

    End{}
    <#
		.SYNOPSIS
			Converts Hex to ARGB values

		.DESCRIPTION
			Converts Hex to ARGB values. Hex values are needed to apply ISE colors in script

		.PARAMETER Hex_Val
			An 8 character Hex value 

        .EXAMPLE
			PS C:\> $ARGB = Convert-HexToARGB $HexValue

            Assigns converted hex value to ARGB variable

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Convert-HexToARGB

#-----------------------------
#--  Convert-ARGBToHex
#-----------------------------
Function Convert-ARGBToHex {
    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$True)]
        [string]$RGB_Val
    )
    
    Begin{}

    Process {
        #-separate the ARGB values
        $var_RGB = $RGB_Val.split(",")

        #-Convert values to Hex
        $var_A = [Convert]::ToString($var_RGB[0], 16).ToUpper()
        $var_R = [Convert]::ToString($var_RGB[1], 16).ToUpper()
        $var_G = [Convert]::ToString($var_RGB[2], 16).ToUpper()
        $var_B = [Convert]::ToString($var_RGB[3], 16).ToUpper()

        #-pad single digit values to ensure 8 character Hex is returned
        If ($var_A.Length -eq 1) {$var_A = "0$var_A"}
        If ($var_R.Length -eq 1) {$var_R = "0$var_R"}
        If ($var_G.Length -eq 1) {$var_G = "0$var_G"}
        If ($var_B.Length -eq 1) {$var_B = "0$var_B"}

        #-Output concatenated hex value
        Write-Output "#$var_A$var_R$var_G$var_B"
    }

    End{}
    <#
    	.SYNOPSIS
		    Converts ARGB to Hex values

		.DESCRIPTION
			Converts ARGB to Hex values. ARGB values are needed to save console colors to xml format

		.PARAMETER Hex_Val
			The ARGB value 

        .EXAMPLE
			PS C:\> $Hex = Convert-ARGBToHex $ARGBValue

            Assigns converted ARGB  value to Hex variable

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Convert-ARGBToHex

#-----------------------------
#--  Get-CurrentISETheme
#-----------------------------
Function Get-CurrentISETheme {
    #-Create empty ISE Color object array
    $CurrentISEObjects = @()

    #-Get base colors
    $baseClass = @()

    $hash = @{Attribute = "ErrorForegroundColor"; Hex = $psISE.Options.ErrorForegroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ErrorBackgroundColor"; Hex = $psISE.Options.ErrorBackgroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "WarningForegroundColor"; Hex = $psISE.Options.WarningForegroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "WarningBackgroundColor"; Hex = $psISE.Options.WarningBackgroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "VerboseForegroundColor"; Hex = $psISE.Options.VerboseForegroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "VerboseBackgroundColor"; Hex = $psISE.Options.VerboseBackgroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "DebugForegroundColor"; Hex = $psISE.Options.DebugForegroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "DebugBackgroundColor"; Hex = $psISE.Options.DebugBackgroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ConsolePaneBackgroundColor"; Hex = $psISE.Options.ConsolePaneBackgroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ConsolePaneTextBackgroundColor"; Hex = $psISE.Options.ConsolePaneTextBackgroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ConsolePaneForegroundColor"; Hex = $psISE.Options.ConsolePaneForegroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ScriptPaneBackgroundColor"; Hex = $psISE.Options.ScriptPaneBackgroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ScriptPaneForegroundColor"; Hex = $psISE.Options.ScriptPaneForegroundColor}                                    
    $Object = New-Object PSObject -Property $hash
    $baseClass += $Object

    ForEach ($obj in $baseClass) {
        $ARGBObj = Convert-HexToARGB $obj.Hex

        $tcObj = New-Object -Type PSObject
        $tcObj | Add-Member -MemberType NoteProperty -Name Class –Value "Base"
        $tcObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $obj.Attribute
        $tcObj | Add-Member -MemberType NoteProperty -Name A –Value $ARGBObj.A
        $tcObj | Add-Member -MemberType NoteProperty -Name R –Value $ARGBObj.R
        $tcObj | Add-Member -MemberType NoteProperty -Name G –Value $ARGBObj.G
        $tcObj | Add-Member -MemberType NoteProperty -Name B –Value $ARGBObj.B
        $tcObj | Add-Member -MemberType NoteProperty -Name Hex –Value $obj.Hex
        $CurrentISEObjects += $tcObj
    }

    #-Get TokenColors
    ForEach ($Token in $psISE.Options.TokenColors) {
        [string]$HexValue = $Token.Value

        $ARGBObj = Convert-HexToARGB $HexValue

        $tcObj = New-Object -Type PSObject
        $tcObj | Add-Member -MemberType NoteProperty -Name Class –Value "TokenColors"
        $tcObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Token.Key
        $tcObj | Add-Member -MemberType NoteProperty -Name A –Value $ARGBObj.A
        $tcObj | Add-Member -MemberType NoteProperty -Name R –Value $ARGBObj.R
        $tcObj | Add-Member -MemberType NoteProperty -Name G –Value $ARGBObj.G
        $tcObj | Add-Member -MemberType NoteProperty -Name B –Value $ARGBObj.B
        $tcObj | Add-Member -MemberType NoteProperty -Name Hex –Value $HexValue
        $CurrentISEObjects += $tcObj  
    }
    
    $ARGBObj = $null

    #-Get ConsoleTokenColors
    ForEach ($Token in $psISE.Options.ConsoleTokenColors) {
        [string]$HexValue = $Token.Value

        $ARGBObj = Convert-HexToARGB $HexValue
        
        $ctcObj = New-Object -Type PSObject
        $ctcObj | Add-Member -MemberType NoteProperty -Name Class –Value "ConsoleTokenColors"
        $ctcObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Token.Key
        $ctcObj | Add-Member -MemberType NoteProperty -Name A –Value $ARGBObj.A
        $ctcObj | Add-Member -MemberType NoteProperty -Name R –Value $ARGBObj.R
        $ctcObj | Add-Member -MemberType NoteProperty -Name G –Value $ARGBObj.G
        $ctcObj | Add-Member -MemberType NoteProperty -Name B –Value $ARGBObj.B
        $ctcObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Token.Value
        $CurrentISEObjects += $ctcObj 
    }

    $ARGBObj = $null

    #-Get XmlTokenColors
    ForEach ($Token in $psISE.Options.XmlTokenColors) {
        [string]$HexValue = $Token.Value

        $ARGBObj = Convert-HexToARGB $HexValue

        $xtcObj = New-Object -Type PSObject
        $xtcObj | Add-Member -MemberType NoteProperty -Name Class –Value "XmlTokenColors"
        $xtcObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Token.Key
        $xtcObj | Add-Member -MemberType NoteProperty -Name A –Value $ARGBObj.A
        $xtcObj | Add-Member -MemberType NoteProperty -Name R –Value $ARGBObj.R
        $xtcObj | Add-Member -MemberType NoteProperty -Name G –Value $ARGBObj.G
        $xtcObj | Add-Member -MemberType NoteProperty -Name B –Value $ARGBObj.B
        $xtcObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Token.Value
        $CurrentISEObjects += $xtcObj 
    }

    #-Get Font and Name
    $othObj = New-Object -Type PSObject
    $othObj | Add-Member -MemberType NoteProperty -Name Class –Value "Other"
    $othObj | Add-Member -MemberType NoteProperty -Name FontFamily –Value $psISE.Options.FontName
    $othObj | Add-Member -MemberType NoteProperty -Name FontSize –Value $psISE.Options.FontSize
    $CurrentISEObjects += $othObj

    #-Return Output
    $CurrentISEObjects
    <#
    	.SYNOPSIS
		    Gets current ISE theme

		.DESCRIPTION
			Gets current ISE theme. Hex colors are converted to ARGB
            and added back to the returned objects.

        .EXAMPLE
			PS C:\> $CurrentISETheme = Get-CurrentISETheme

            Assigns Current ISE theme properties to CurrentISETheme

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#> 
} #end function Get-CurrentISETheme

#-----------------------------
#--  Get-ISETheme
#-----------------------------
Function Get-ISETheme {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName='fromfile',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$File,

        [Parameter(Mandatory=$True,ParameterSetName='fromreg',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$ThemeName
    )

    Begin{}

    Process {
        #-Determine proper xml assignment according to whether an xml file was passed or a registry Theme
        If ($File) {        
            [xml]$xml = get-content $File
        } Else {
            $Theme = Get-ItemProperty HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes -Name $ThemeName
            $Theme | ForEach-Object {
                $xml = $_.$ThemeName
            }
        }

        #-Create xml object array to store xml values from the Theme
        $xmlObjects = @()

        $x = 0
        $xml.StorableColorTheme.Keys.String | ForEach-Object {
            #-Set class according to presence of a "\" in the attribute name
            If ($_.Contains("\")) {
                $Class = $_.Substring(0,$_.IndexOf('\'))
                $Attribute = $_.Substring($_.IndexOf('\') + 1)
            } Else {
                $Class = "Base"
                $Attribute = $_
            }
            
            #-Get the ARGB values from the xml
            $var_A = $xml.StorableColorTheme.Values.Color[$x].A
            $var_R = $xml.StorableColorTheme.Values.Color[$x].R
            $var_G = $xml.StorableColorTheme.Values.Color[$x].G
            $var_B = $xml.StorableColorTheme.Values.Color[$x].B

            #-Convert ARGB values to Hex
            $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"
            
            #-Create new xml object and add it the the xml object array
            $xmlObj = New-Object -Type PSObject
            $xmlObj | Add-Member -MemberType NoteProperty -Name Class –Value $Class
            $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Attribute
            $xmlObj | Add-Member -MemberType NoteProperty -Name A –Value $var_A
            $xmlObj | Add-Member -MemberType NoteProperty -Name R –Value $var_R
            $xmlObj | Add-Member -MemberType NoteProperty -Name G –Value $var_G
            $xmlObj | Add-Member -MemberType NoteProperty -Name B –Value $var_B
            $xmlObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Hex
            $xmlObjects += $xmlObj        
            $x = $x + 1        
        }

        #-Get Font
        $xmlObj = New-Object -Type PSObject
        $xmlObj | Add-Member -MemberType NoteProperty -Name Class –Value "Other"
        $xmlObj | Add-Member -MemberType NoteProperty -Name Name –Value $xml.StorableColorTheme.Name
        $xmlObj | Add-Member -MemberType NoteProperty -Name FontFamily –Value $xml.StorableColorTheme.FontFamily
        $xmlObj | Add-Member -MemberType NoteProperty -Name FontSize –Value $xml.StorableColorTheme.FontSize
        $xmlObjects += $xmlObj

        #-Return xml object array 
        $xmlObjects       
    }

    End{}
    <#
    	.SYNOPSIS
		    Gets an ISE theme 

		.DESCRIPTION
			Gets an ISE them from either the registry or xml file

		.PARAMETER File
			An ISE theme xml filename

 		.PARAMETER ThemeName
			The name of an ISE theme stored in the registry

        .EXAMPLE
			PS C:\> $Theme = Get-FileName | Get-ISETheme

            Gets the ISE theme information from the supplied xml file and assigns it to Theme

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Get-ISETheme

#-----------------------------
#--  Get-ImportedISEThemes
#-----------------------------
Function Get-ImportedISEThemes {
    #-Get theme values from registry
    $Themes = Get-Item registry::HKey_Current_User\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes | Select-Object -ExpandProperty Property

    #-Get name and xml content and return it as an object
    $Themes | ForEach-Object {
        $ThemeName = $_
        $Theme = Get-ItemProperty HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes -Name $ThemeName
        $Theme | ForEach-Object {
            $xml = $_.$ThemeName
        }

        $hash = @{ThemeName = $_; XML = $xml}                                    
        $Object = New-Object PSObject -Property $hash
        $Object
        
    }
    <#
    	.SYNOPSIS
		    Returns imported themes

		.DESCRIPTION
			Returns imported themes from the registry

        .EXAMPLE
			PS C:\> $Themes = Get-ImportedISEThemes 

            Gets the imported ISE themes from the registry and assigns it to Themes

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Get-ImportedISEThemes

#-----------------------------
#--  Set-ISETheme
#-----------------------------
Function Set-ISETheme {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName='FromFile',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$File,

        [Parameter(Mandatory=$True,ParameterSetName='FromReg',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$ThemeName,

        [Parameter(Mandatory=$True,ParameterSetName='FromObj',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [object]$ThemeObject
    )

    Begin{}

    Process {
        #-Determine if a file, object or theme name was passed and retrieve the theme accordingly
        If ($ThemeObject) {
           $xmlObjects = $ThemeObject 
        } Else {
            If ($File) {
                $xmlObjects = Get-ISETheme -File $File
            } Else {
                $xmlObjects = Get-ISETheme -ThemeName $ThemeName
            }
        }
        
        #-Set Base colors
        $xmlObjects | ForEach-Object {
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ErrorForegroundColor")) {$psISE.Options.ErrorForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ErrorBackgroundColor")) {$psISE.Options.ErrorBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("WarningForegroundColor")) {$psISE.Options.WarningForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("WarningBackgroundColor")) {$psISE.Options.WarningBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("VerboseForegroundColor")) {$psISE.Options.VerboseForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("VerboseBackgroundColor")) {$psISE.Options.VerboseBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("DebugForegroundColor")) {$psISE.Options.DebugForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("DebugBackgroundColor")) {$psISE.Options.DebugBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ConsolePaneBackgroundColor")) {$psISE.Options.ConsolePaneBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ConsolePaneTextBackgroundColor")) {$psISE.Options.ConsolePaneTextBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ConsolePaneForegroundColor")) {$psISE.Options.ConsolePaneForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ScriptPaneBackgroundColor")) {$psISE.Options.ScriptPaneBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ScriptPaneForegroundColor")) {$psISE.Options.ScriptPaneForegroundColor = $_.Hex}
        }
        
        $xmlObjects | ForEach-Object {
            #-Set TokenColors
            If ($_.Class -eq "TokenColors") {
                $psISE.Options.TokenColors.item($_.Attribute) = $_.Hex
            }
        
            #-Set ConsoleTokenColors
            If ($_.Class -eq "ConsoleTokenColors") {
                $psISE.Options.ConsoleTokenColors.item($_.Attribute) = $_.Hex
            }
       
            #-Set XmlTokenColors
            If ($_.Class.Contains("XmlTokenColors")) {
                If ($_.Attribute.Length -gt 2) {
                    $psISE.Options.XmlTokenColors.item($_.Attribute) = $_.Hex #[$_.Attribute] = $_.Hex
                }
            }

            #-Set Font
            If ($_.Class.Contains("Other") -and !$ThemeObject) {
                $psISE.Options.FontName = $_.FontFamily
                $psISE.Options.FontSize = $_.FontSize
            }
        }
    }
    End{}
    <#
    	.SYNOPSIS
		    Applies ISE theme to current session

		.DESCRIPTION
			Applies ISE theme to current session

		.PARAMETER File
			An ISE theme xml filename

 		.PARAMETER ThemeName
			The name of an ISE theme stored in the registry

        .EXAMPLE
			PS C:\> Get-FileName | Set-ISETheme

            Gets the ISE theme information from the supplied xml file and assigns it to Theme

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Set-ISETheme

#-----------------------------
#--  Import-ISEThemeFile
#-----------------------------
Function Import-ISEThemeFile {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [object]$FileName,

        [Parameter()]
        [switch]$ApplyTheme
    )

    Begin{}

    Process {
        # Get fullname if gci object passed
        If ($FileName.FullName) {
            [string]$FileName = $FileName.FullName
        }

        #-Create xml variable from file name
        [xml]$xml = get-content $FileName
        #Create xml string variable from file name
        [string]$xmlString = get-content $FileName

        #-Get theme name for registry value name
        $ThemeName = $xml.StorableColorTheme.Name

        #-Set value data to the xml string
        Set-ItemProperty HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes -Name $ThemeName -Value $xmlString -Type String

        #-Apply theme to current session if called
        If ($ApplyTheme) {
            Set-ISETheme -ThemeName $ThemeName
        }
    }

    End{}
    <#
    	.SYNOPSIS
		    Imports an ISE theme xml file into the registry

		.DESCRIPTION
			Imports an ISE theme xml file into the registry and applies it
            to the current session if ApplyTheme is passed

		.PARAMETER File
			An ISE theme xml filename

 		.PARAMETER ApplyTheme
			Switch for applying the theme after importing it.

        .EXAMPLE
			PS C:\> Import-ISEThemeFile "C:\ISEthemes\.StorableColorTheme.ps1xml"

            Imports ISE theme to the registry

        .EXAMPLE
			PS C:\> Get-FileName | Import-ISEThemeFile -ApplyTheme

            Imports piped in ISE theme to the registry and applies the theme to the current session

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Import-ISEThemeFile

#-----------------------------
#--  Export-ISEThemeFile
#-----------------------------
Function Export-ISEThemeFile {
    [cmdletbinding()]
    Param(
        [Parameter(ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$ISETheme,

        [Parameter(ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$SaveToISE
    )

    Begin{}

    Process {
        # Determine whether exporting current theme or a saved theme
        If ($ISETheme) {
            $Theme = Get-ISETheme -ThemeName $ISETheme
            $XmlTheme = $Theme
        } Else {
            $XmlTheme = Get-CurrentISETheme
        }        

        # Set the File Name
        $FilePath = Get-SaveFile

        # Trim the extension if found
        If ($FilePath.Length -gt  26) {
            If ($FilePath.Substring($FilePath.Length - 26) -ieq ".StorableColorTheme.ps1xml") {
                $FilePath = $FilePath.Substring(0,$FilePath.Length - 26)
            }
        }

        # Set ThemeName for ISE import
        $ThemeName = $FilePath.Substring($FilePath.LastIndexOf("\") + 1)
        # Set file extension
        $FilePath = "$FilePath.StorableColorTheme.ps1xml"
 
        # Create The Document
        $XmlWriter = New-Object System.XMl.XmlTextWriter($filePath,[Text.Encoding]::Unicode) 

        # Set The Formatting
        $xmlWriter.Formatting = "Indented"
        $xmlWriter.Indentation = "4"
 
        # Write the XML Decleration
        $xmlWriter.WriteStartDocument()

        # Write Root Element
        $xmlWriter.WriteStartElement("StorableColorTheme")
        $XmlWriter.WriteAttributeString("xmlns:xsd","http://www.w3.org/2001/XMLSchema") 
        $XmlWriter.WriteAttributeString("xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance")

        # Write Keys
        $xmlWriter.WriteStartElement("Keys")
        ForEach ($Attribute in $XmlTheme) {
            #Write Base Colors Keys
            If ($Attribute.Class -eq "Base") {
                $xmlWriter.WriteElementString("string",$Attribute.Attribute)
            }

            # Write TokenColors Keys
            If ($Attribute.Class -eq "TokenColors") {
                $xmlWriter.WriteElementString("string","TokenColors\$($Attribute.Attribute)")
            }

            # Write ConsoleTokenColors Keys
            If ($Attribute.Class -eq "ConsoleTokenColors") {
                $xmlWriter.WriteElementString("string","ConsoleTokenColors\$($Attribute.Attribute)")
            }

            # Write XmlTokenColors Keys
            If ($Attribute.Class -eq "XmlTokenColors") {
                $xmlWriter.WriteElementString("string","XmlTokenColors\$($Attribute.Attribute)")
            }
        }
        $xmlWriter.WriteEndElement() # <-- Closing Keys

        # Write Values
        $xmlWriter.WriteStartElement("Values")

        ForEach ($Attribute in $XmlTheme) {
            # Write Base Colors Values
            If ($Attribute.Class -eq "Base") {
                $xmlWriter.WriteStartElement("Color")
                $xmlWriter.WriteElementString("A",$Attribute.A)
                $xmlWriter.WriteElementString("R",$Attribute.R)
                $xmlWriter.WriteElementString("G",$Attribute.G)
                $xmlWriter.WriteElementString("B",$Attribute.B)
                $xmlWriter.WriteEndElement() # <-- Closing Color
            }

            # Write TokenColors Values
            If ($Attribute.Class -eq "TokenColors") {
                $xmlWriter.WriteStartElement("Color")
                $xmlWriter.WriteElementString("A",$Attribute.A)
                $xmlWriter.WriteElementString("R",$Attribute.R)
                $xmlWriter.WriteElementString("G",$Attribute.G)
                $xmlWriter.WriteElementString("B",$Attribute.B)
                $xmlWriter.WriteEndElement() # <-- Closing Color
            }

            # Write ConsoleTokenColors Values
            If ($Attribute.Class -eq "ConsoleTokenColors") {
                $xmlWriter.WriteStartElement("Color")
                $xmlWriter.WriteElementString("A",$Attribute.A)
                $xmlWriter.WriteElementString("R",$Attribute.R)
                $xmlWriter.WriteElementString("G",$Attribute.G)
                $xmlWriter.WriteElementString("B",$Attribute.B)
                $xmlWriter.WriteEndElement() # <-- Closing Color
            }

            # Write XmlTokenColors Values
            If ($Attribute.Class -eq "XmlTokenColors") {
                $xmlWriter.WriteStartElement("Color")
                $xmlWriter.WriteElementString("A",$Attribute.A)
                $xmlWriter.WriteElementString("R",$Attribute.R)
                $xmlWriter.WriteElementString("G",$Attribute.G)
                $xmlWriter.WriteElementString("B",$Attribute.B)
                $xmlWriter.WriteEndElement() # <-- Closing Color
            } 
         }
         $xmlWriter.WriteEndElement() # <-- Closing Values

        #Write Name and Font Attribu
        If ($Attribute.Class -eq "Other") {
            $xmlWriter.WriteElementString("Name",$ThemeName)
            $xmlWriter.WriteElementString("FontFamily",$Attribute.FontFamily)
            $xmlWriter.WriteElementString("FontSize",$Attribute.FontSize)
        }
 
        # Write Close Tag for Root Element
        $xmlWriter.WriteEndElement() # <-- Closing StorableColorTheme
 
        # End the XML Document
        $xmlWriter.WriteEndDocument()
 
        # Finish The Document
        $xmlWriter.Finalize
        $xmlWriter.Flush | out-null
        $xmlWriter.Close()

        If ($SaveToISE) {
            Import-ISEThemeFile $FilePath
        }
    }

    End{}
    <#
    	.SYNOPSIS
		    Exports an ISE theme to an xml file

		.DESCRIPTION
			Exports an ISE theme to an xml file and saves in the registry
            if SaveToISE is passed

		.PARAMETER RegistryTheme
			Optionally supply an ISE theme name to export that theme

 		.PARAMETER SaveToISE
			After exporting, save the theme to the registry

        .EXAMPLE
			PS C:\> Export-ISEThemeFile -ISETheme "Monokai"

            Exports ISE theme to an xml file

        .EXAMPLE
			PS C:\> Export-ISEThemeFile -SaveToISE

            Exports the current ISE theme and saves it in the ISE for future reference

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Import-ISEThemeFile

#-----------------------------
#--  Remove-ISETheme
#-----------------------------
Function Remove-ISETheme {
    [cmdletbinding()]
    Param(
        [Parameter(ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$ThemeName
    )

    Begin{}

    Process {
        Remove-ItemProperty HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes -Name $ThemeName
    }

    End{}
    <#
    	.SYNOPSIS
		    Deletes an ISE theme from the ISE

		.DESCRIPTION
			Deletes an ISE theme from the ISE

		.PARAMETER ThemeName
			An ISE theme name

        .EXAMPLE
			PS C:\> Remove-ISETheme "Monokai"

            Deletes an ISE theme from the ISE

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
} #end function Remove-ISETheme

Function Set-ISEColor {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName='Cooler',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Cooler,

        [Parameter(Mandatory=$True,ParameterSetName='Warmer',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Warmer,

        [Parameter(Mandatory=$True,ParameterSetName='Greener',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Greener,

        [Parameter(Mandatory=$True,ParameterSetName='Darker',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Darker,

        [Parameter(Mandatory=$True,ParameterSetName='Lighter',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Lighter,

        [Parameter(ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [int]$Degree = 20
    )

    Begin{$XmlTheme = Get-CurrentISETheme; $Subtract = $Degree / 2}

    Process {
        $NewColors = @()

        If ($Cooler) {
            ForEach ($Attribute in $XmlTheme) {
                # Rewrite new color values to NewColors
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R - $Subtract) -ge 0) {$var_R = $Attribute.R - $Subtract} Else {$var_R = $Attribute.R}
                    $var_G = $Attribute.G
                    If (($Attribute.B + $Degree) -lt 255) {$var_B = $Attribute.B + $Degree} Else {$var_B = $Attribute.B}
                        
                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"

                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class –Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A –Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R –Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G –Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B –Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Hex
                    $NewColors += $xmlObj
                        
                }
            }
        }

        If ($Warmer) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A 
                    If (($Attribute.R + $Degree) -lt 255) {$var_R = $Attribute.R + $Degree} Else {$var_R = $Attribute.R}
                    $var_G = $Attribute.G
                    If (($Attribute.B - $Subtract) -ge 0) {$var_B = $Attribute.B - $Subtract} Else {$var_B = $Attribute.B}
                        
                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"
                        
                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class –Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A –Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R –Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G –Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B –Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Hex
                    $NewColors += $xmlObj                              
                }
            } 
        }

        If ($Greener) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R - $Subtract) -ge 0) {$var_R = $Attribute.R - ($Subtract / 2)} Else {$var_R = $Attribute.R}
                    If (($Attribute.G + $Degree) -lt 255) {$var_G = $Attribute.G + $Degree} Else {$var_G = $Attribute.G}
                    If (($Attribute.B - $Subtract) -ge 0) {$var_B = $Attribute.B - ($Subtract / 2)} Else {$var_B = $Attribute.B}
                        
                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"
                        
                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class –Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A –Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R –Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G –Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B –Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Hex
                    $NewColors += $xmlObj                              
                }
            } 
        }

        If ($Darker) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R - $Degree) -ige 0) {$var_R = $Attribute.R - $Degree} Else {$var_R = $Attribute.R}
                    If (($Attribute.G - $Degree) -ige 0) {$var_G = $Attribute.G - $Degree} Else {$var_G = $Attribute.G}
                    If (($Attribute.B - $Degree) -ige 0) {$var_B = $Attribute.B - $Degree} Else {$var_B = $Attribute.B}
                        
                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"
                        
                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class –Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A –Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R –Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G –Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B –Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Hex
                    $NewColors += $xmlObj                              
                }
            } 
        }

        If ($Lighter) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R + $Degree) -lt 255) {$var_R = $Attribute.R + $Degree} Else {$var_R = $Attribute.R}
                    If (($Attribute.G + $Degree) -lt 255) {$var_G = $Attribute.G + $Degree} Else {$var_G = $Attribute.G}
                    If (($Attribute.B + $Degree) -lt 255) {$var_B = $Attribute.B + $Degree} Else {$var_B = $Attribute.B}
                        
                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"
                        
                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class –Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute –Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A –Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R –Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G –Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B –Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex –Value $Hex
                    $NewColors += $xmlObj                              
                }
            } 
        }


    }

    End {Set-ISETheme -ThemeObject $NewColors}
    <#
        .SYNOPSIS
		    Changes ISE Theme colors according to switch

	    .DESCRIPTION
		    Changes ISE Theme colors according to switch. It does this 
            by adding or subtracting values in the ARGB table

	    .PARAMETER Cooler
		    Increases blue color values and decreases red by half

	    .PARAMETER Warmer
		    Increases red color values and decreases blue by half

	    .PARAMETER Greener
		    Increases green color values and decreases blue and red by a quarter

	    .PARAMETER Darker
		    Decreases all color values

	    .PARAMETER Lighter
		    Increases all color values

	    .PARAMETER Degree
		    Amount to add or subtract. Default value: 20

        .EXAMPLE
		    PS C:\> Set-ISEColor -Cooler

            Deletes an ISE theme from the registry

	    .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
}#end function Set-ISEThemeWarmth

#-----------------------------
#--  Select-ISETheme
#-----------------------------
Function Select-ISETheme {
    #========================================================================
    # Code Generated By: SAPIEN Technologies, Inc., PowerShell Studio 2014 v4.1.46
    # Generated On: 3/18/2014 10:19 AM
    # Generated By: Jeff Pollock
    #========================================================================
        <#
    	.SYNOPSIS
		    Selects and applies an ISE theme from the registry.

		.DESCRIPTION
			Selects and applies an ISE theme from the registry.

		.EXAMPLE
			PS C:\> Select-ISETheme 

            Selects an ISE theme from the registry

		.NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock 
            http://Lifeinpowerhsell.blogspot.com                                         
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
	#>
    #----------------------------------------------
    #region Application Functions
    #----------------------------------------------

    function OnApplicationLoad {
	    return $true #return true for success or false for failure
    }

    function OnApplicationExit {
	    $script:ExitCode = 0 #Set the exit code for the Packager
    }

    #endregion Application Functions

    #----------------------------------------------
    # Generated Form Function
    #----------------------------------------------
    function Call-Theme_Selector_psf {

	    #----------------------------------------------
	    #region Import the Assemblies
	    #----------------------------------------------
	    [void][reflection.assembly]::Load('mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	    [void][reflection.assembly]::Load('System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	    [void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	    [void][reflection.assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	    [void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	    [void][reflection.assembly]::Load('System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	    [void][reflection.assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	    [void][reflection.assembly]::Load('System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	    [void][reflection.assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	    #endregion Import Assemblies

	    #----------------------------------------------
	    #region Generated Form Objects
	    #----------------------------------------------
	    [System.Windows.Forms.Application]::EnableVisualStyles()
	    $formISEThemeSelector = New-Object 'System.Windows.Forms.Form'
        $buttonExit = New-Object 'System.Windows.Forms.Button'
	    $buttonSelectTheme = New-Object 'System.Windows.Forms.Button'
	    $listboxThemes = New-Object 'System.Windows.Forms.ListBox'
	    $InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
        $formISEThemeSelector.Icon = [Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path) 
	    #endregion Generated Form Objects

	    #----------------------------------------------
	    # User Generated Script
	    #----------------------------------------------
	    $buttonSelectTheme_Click={
            Set-ISETheme -ThemeName $listboxThemes.SelectedItem
            $formISEThemeSelector.Close()
        }

        $formISEThemeSelector_KeyDown={
            if ($_.KeyCode -eq "Enter") {Write-host "Inside";$buttonSelectTheme_Click}
        }

        $listboxThemes_KeyDown={
            if ($_.KeyCode -eq "Enter") {
                Set-ISETheme -ThemeName $listboxThemes.SelectedItem
                $formISEThemeSelector.Close()
            }
        }
        
        $buttonExit_Click={$formISEThemeSelector.Close()}	
	
	    $formISEThemeSelector_Load={
		    #TODO: Initialize Form Controls here
            $Themes = Get-ImportedISEThemes | Select ThemeName
            $Themes | ForEach-Object {
                Load-ListBox $listboxThemes $_.ThemeName -Append
            }		
	    }
	
	    #region Control Helper Functions
	    function Load-ListBox 
	    {
	    <#
		    .SYNOPSIS
			    This functions helps you load items into a ListBox or CheckedListBox.
	
		    .DESCRIPTION
			    Use this function to dynamically load items into the ListBox control.
	
		    .PARAMETER  ListBox
			    The ListBox control you want to add items to.
	
		    .PARAMETER  Items
			    The object or objects you wish to load into the ListBox's Items collection.
	
		    .PARAMETER  DisplayMember
			    Indicates the property to display for the items in this control.
		
		    .PARAMETER  Append
			    Adds the item(s) to the ListBox without clearing the Items collection.
		
		    .EXAMPLE
			    Load-ListBox $ListBox1 "Red", "White", "Blue"
		
		    .EXAMPLE
			    Load-ListBox $listBox1 "Red" -Append
			    Load-ListBox $listBox1 "White" -Append
			    Load-ListBox $listBox1 "Blue" -Append
		
		    .EXAMPLE
			    Load-ListBox $listBox1 (Get-Process) "ProcessName"
	    #>
		    Param (
			    [ValidateNotNull()]
			    [Parameter(Mandatory=$true)]
			    [System.Windows.Forms.ListBox]$ListBox,
			    [ValidateNotNull()]
			    [Parameter(Mandatory=$true)]
			    $Items,
		        [Parameter(Mandatory=$false)]
			    [string]$DisplayMember,
			    [switch]$Append
		    )
		
		    if(-not $Append)
		    {
			    $listBox.Items.Clear()	
		    }
		
		    if($Items -is [System.Windows.Forms.ListBox+ObjectCollection])
		    {
			    $listBox.Items.AddRange($Items)
		    }
		    elseif ($Items -is [Array])
		    {
			    $listBox.BeginUpdate()
			    foreach($obj in $Items)
			    {
				    $listBox.Items.Add($obj)
			    }
			    $listBox.EndUpdate()
		    }
		    else
		    {
			    $listBox.Items.Add($Items)	
		    }
	
		    $listBox.DisplayMember = $DisplayMember	
	    }
	    #endregion
	
	    # --End User Generated Script--
	    #----------------------------------------------
	    #region Generated Events
	    #----------------------------------------------
	
	    $Form_StateCorrection_Load=
	    {
		    #Correct the initial state of the form to prevent the .Net maximized form issue
		    $formISEThemeSelector.WindowState = $InitialFormWindowState
	    }
	
	    $Form_Cleanup_FormClosed=
	    {
		    #Remove all event handlers from the controls
		    try
		    {
			    $formISEThemeSelector.remove_Load($formISEThemeSelector_Load)
			    $formISEThemeSelector.remove_Load($Form_StateCorrection_Load)
			    $formISEThemeSelector.remove_FormClosed($Form_Cleanup_FormClosed)
		    }
		    catch [Exception]
		    { }
	    }
	    #endregion Generated Events

	    #----------------------------------------------
	    #region Generated Form Code
	    #----------------------------------------------
	    $formISEThemeSelector.SuspendLayout()
	    #
	    # formISEThemeSelector
	    #
	    $formISEThemeSelector.Controls.Add($buttonExit)
        $formISEThemeSelector.Controls.Add($buttonSelectTheme)
	    $formISEThemeSelector.Controls.Add($listboxThemes)
	    $formISEThemeSelector.ClientSize = '228, 278'
        $formISEThemeSelector.FormBorderStyle = 'None'
	    $formISEThemeSelector.Name = "formISEThemeSelector"
	    $formISEThemeSelector.Text = "Theme Selector"
	    $formISEThemeSelector.add_Load($formISEThemeSelector_Load)
        $formISEThemeSelector.StartPosition = "CenterScreen"
        $formISEThemeSelector.MinimizeBox = $False
        $formISEThemeSelector.MaximizeBox = $False
        $formISEThemeSelector.BackColor =  $PopupColor
        $formISEThemeSelector.Add_KeyDown($formISEThemeSelector_KeyDown) 
        #
	    # buttonExit
	    #
	    $buttonExit.Location = '117, 233'
	    $buttonExit.Name = "buttonExit"
	    $buttonExit.Size = '96, 30'
	    $buttonExit.TabIndex = 2
	    $buttonExit.Text = "E&xit"
	    $buttonExit.UseVisualStyleBackColor = $True
        $buttonExit.add_Click($buttonExit_Click)
	    #
	    # buttonSelectTheme
	    #
	    $buttonSelectTheme.Location = '14, 233'
	    $buttonSelectTheme.Name = "buttonSelectTheme"
	    $buttonSelectTheme.Size = '96, 30'
	    $buttonSelectTheme.TabIndex = 1
	    $buttonSelectTheme.Text = "&Select"
	    $buttonSelectTheme.UseVisualStyleBackColor = $True
        $buttonSelectTheme.add_Click($buttonSelectTheme_Click)
	    #
	    # listboxThemes
	    #
        $listboxThemes.Font = "Microsoft Sans Serif, 12pt"	    
        $listboxThemes.FormattingEnabled = $True
	    $listboxThemes.ItemHeight = 17
	    $listboxThemes.Location = '14, 15'
	    $listboxThemes.Name = "listboxThemes"
	    $listboxThemes.Size = '199, 220'
	    $listboxThemes.TabIndex = 0
        $listboxThemes.add_KeyDown($listboxThemes_KeyDown)


	    $formISEThemeSelector.ResumeLayout($false)

	    #endregion Generated Form Code

	    #----------------------------------------------

	    #Save the initial state of the form
	    $InitialFormWindowState = $formISEThemeSelector.WindowState
	    #Init the OnLoad event to correct the initial state of the form
	    $formISEThemeSelector.add_Load($Form_StateCorrection_Load)
	    #Clean up the control events
	    $formISEThemeSelector.add_FormClosed($Form_Cleanup_FormClosed)
	    #Show the Form
	    return $formISEThemeSelector.ShowDialog()

    } #End Function

    #Call OnApplicationLoad to initialize
    if((OnApplicationLoad) -eq $true)
    {
        $BackgroundColor = $psISE.Options.ScriptPaneBackgroundColor
        IF ($BackgroundColor.A -lt 235) {$BackgroundColor.A = $BackgroundColor.A + 20}
        IF ($BackgroundColor.R -lt 235) {$BackgroundColor.R = $BackgroundColor.R + 20}
        IF ($BackgroundColor.G -lt 235) {$BackgroundColor.G = $BackgroundColor.G + 20}
        IF ($BackgroundColor.B -lt 235) {$BackgroundColor.B = $BackgroundColor.B + 20}
        $PopupColor = Convert-ARGBToHex "$($BackgroundColor.A),$($BackgroundColor.R),$($BackgroundColor.G),$($BackgroundColor.B)"
	    #Call the form
	    Call-Theme_Selector_psf | Out-Null
	    #Perform cleanup
	    OnApplicationExit
    }
    
} #end function Select-ISETheme

function Add-ISEThemeMenu {
#    [cmdletbinding()]
#    Param (
#        [Parameter()] [ValidateNotNullOrEmpty()]
#        [string] $MenuName,
#            
#        [Parameter()] [ValidateNotNullOrEmpty()]
#        [string] $ShortcutDirectory
#    )


    Process {
        $parentAdded = $psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("ISE Color Themes",$null,$null)       

        $Functions = @()

        $OutputObj  = New-Object -Type PSObject
        $OutputObj | Add-Member -MemberType NoteProperty -Name FunctionName –Value "Theme Selector"
        $OutputObj | Add-Member -MemberType NoteProperty -Name "Scriptblock" –Value "Select-ISETheme" #ShortcutKey "ALT+SHIFT+W"
        $OutputObj | Add-Member -MemberType NoteProperty -Name ShortcutKey –Value "CTRL+ALT+SHIFT+T"
        $Functions += $OutputObj 

        $Options = "darker|lighter|warmer|cooler|greener"
        $OptionArray = $Options.Split("|")

        $ShortcutKey = 0

        $optionArray | ForEach-Object {
            $OutputObj  = New-Object -Type PSObject
            $OutputObj | Add-Member -MemberType NoteProperty -Name FunctionName –Value "Set $_"
            $OutputObj | Add-Member -MemberType NoteProperty -Name "Scriptblock" –Value "Set-ISEColor -$_" #ShortcutKey "ALT+SHIFT+W"
            $OutputObj | Add-Member -MemberType NoteProperty -Name ShortcutKey –Value "ALT+SHIFT+$ShortcutKey"
            $Functions += $OutputObj 

            $ShortcutKey += 1
        }

        $Functions | % {
            $global:functionname = $_.FunctionName.ToString()
            $sb=$executioncontext.InvokeCommand.NewScriptBlock($_.Scriptblock)
            $parentAdded.Submenus.Add($functionname,$sb,$_.ShortcutKey) | out-null
        }

        If (!(Test-Path "HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes")) {
            New-Item -Path "HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE" -Name ColorThemes –Force | out-null
        }

        $ThemeMenu = $ParentAdded.SubMenus.Add("Imported Themes",$null,$null)
        $Themes = @()
        $ImportedThemes = Get-ImportedISEThemes        

        $ImportedThemes | ForEach-Object {           
            $OutputObj  = New-Object -Type PSObject
            $OutputObj | Add-Member -MemberType NoteProperty -Name "FunctionName" –Value $_.ThemeName
            $OutputObj | Add-Member -MemberType NoteProperty -Name "Scriptblock" –Value "Set-ISETheme -ThemeName $($_.ThemeName)"
            $Themes += $OutputObj           
        }

        $OutputObj  = New-Object -Type PSObject
        $OutputObj | Add-Member -MemberType NoteProperty -Name "FunctionName" –Value "Import CSE Themes"
        $OutputObj | Add-Member -MemberType NoteProperty -Name "Scriptblock" –Value "Import-GroupISEThemes"
        $Themes += $OutputObj

        $Themes | % {
            $global:functionname = $_.FunctionName.ToString()
            $sb=$executioncontext.InvokeCommand.NewScriptBlock($_.Scriptblock)
            $ThemeMenu.Submenus.Add($functionname,$sb,$null) | out-null
        }
    }
}

Function Import-GroupISEThemes {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory=$True)] [ValidateNotNullOrEmpty()]
        [string] $Directory
    )
    
    gci $Directory -Filter *.ps1xml | select fullname | Import-ISEThemeFile     
}
