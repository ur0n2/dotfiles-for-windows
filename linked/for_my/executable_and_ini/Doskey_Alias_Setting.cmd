::2017. 03. 10
::LeeJunHwan
::This commands make to linux environment on Windows OS
::But, We have powershell... and bash shell on windows 10 
::Just For Fun!!!

@echo off
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

@echo -----------------------------------------------------------------------------
@echo [+]       doskey ls = dir /W /P $*        
@echo [+]       doskey l = dir $*
@echo [+]       doskey ll = dir /A /P $*         
@echo [+]       doskey cp = copy $*            
@echo [+]       doskey rm = del $*              
@echo [+]       doskey mv = move $*            
@echo [+]       doskey grep = findstr $*        
@echo [+]       doskey cat = type $*            
@echo [+]       doskey date = echo %date%   
@echo [+]       doskey ifconfig = ipconfig     
@echo [+]       doskey . = cd ..
@echo [+]       doskey .. = cd ../..
@echo [+]       doskey clear = cls
@echo -----------------------------------------------------------------------------
@echo [+]       2017. 03. 10
@echo [+]       LeeJunHwan
@echo [+]       This commands make to linux environment on Windows OS
@echo [+]       But, We have powershell... and bash shell on windows 10 
@echo [+]       Just For Fun!!!
@echo -----------------------------------------------------------------------------
@echo.
@echo on