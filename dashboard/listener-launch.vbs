' Hidden launcher for Start-JobHuntListener.ps1, used by the JobHuntListener logon task.
' Same trick as cmd-launch.vbs: powershell -WindowStyle Hidden still flashes a console for a
' moment at logon, and this listener runs for the whole session - WshShell.Run style 0 keeps it
' genuinely invisible.
Option Explicit
Dim sh, fso, scriptDir, ps1, cmd
Set sh  = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
ps1 = scriptDir & "\Start-JobHuntListener.ps1"
cmd = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & ps1 & """"
sh.Run cmd, 0, False   ' 0 = hidden window, False = don't wait
