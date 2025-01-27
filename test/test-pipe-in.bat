@echo off
:: Enable delayed expansion to work with arrays
setlocal enabledelayedexpansion

:: Create an array from the passed arguments
set argCount=0
for %%A in (%*) do (
    set /a argCount+=1
    set "args[!argCount!]=%%~A"
)

:: The last argument is the input file
set "input=!args[%argCount%]!"
set /a argCount-=1

:: Reconstruct the command from the remaining arguments
set "command="
for /L %%I in (1,1,%argCount%) do (
    set "command=!command! !args[%%I]!"
)

:: Execute the command with the input file
echo Executing: !command! < !input!
cmd.exe /C "!command! < !input!"
