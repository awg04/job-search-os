' Hidden launcher for the jobhunt-archive:// protocol. Runs archive-uri-handler.ps1 with
' NO console window (WshShell.Run style 0) so archiving happens silently in the background.
Option Explicit
Dim sh, fso, uri, scriptDir, handler, cmd
If WScript.Arguments.Count = 0 Then WScript.Quit
Set sh  = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
uri = WScript.Arguments(0)
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
handler = scriptDir & "\archive-uri-handler.ps1"
cmd = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & handler & """ -Uri """ & uri & """"
sh.Run cmd, 0, False   ' 0 = hidden window, False = don't wait
