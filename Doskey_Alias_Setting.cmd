::2017. 03. 10
::LeeJunHwan
::This commands make to linux environment on Windows OS
::But, We have powershell... and bash shell on windows 10 
::Just For Fun!!!

@echo off
doskey ls = dir /W /P $*
doskey ll = dir /A /P $*
doskey cp = copy $*
doskey rm = del $*
doskey mv = move $*
doskey grep = findstr $*
doskey cat = type $*
doskey date = echo %date%
doskey ifconfig = ipconfig


@echo -----------------------------------------------------------------------------
@echo ¡Ú       doskey ls = dir /W /P $*        
@echo ¡Ú       doskey ll = dir /A /P $*         
@echo ¡Ú       doskey cp = copy $*            
@echo ¡Ú       doskey rm = del $*              
@echo ¡Ú       doskey mv = move $*            
@echo ¡Ú       doskey grep = findstr $*        
@echo ¡Ú       doskey cat = type $*            
@echo ¡Ú       doskey date = echo %date%   
@echo ¡Ú       doskey ifconfig = ipconfig      
@echo -----------------------------------------------------------------------------
@echo ¡Ú       2017. 03. 10
@echo ¡Ú       LeeJunHwan
@echo ¡Ú       This commands make to linux environment on Windows OS
@echo ¡Ú       But, We have powershell... and bash shell on windows 10 
@echo ¡Ú       Just For Fun!!!
@echo -----------------------------------------------------------------------------
@echo.
@echo on