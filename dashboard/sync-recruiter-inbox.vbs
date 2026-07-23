' sync-recruiter-inbox.vbs - hidden launcher for the Recruiter Inbox widget's refresh icon.
' Runs Sync-Widgets.ps1 -Target recruiter with NO console window, and WAITS for it so
' the caller (zebar.shellExec) resolves only once recruiters.json has been rewritten.
' Argument-free on purpose: the widget's zpack argsRegex anchors on this filename.
'
' Keep this file ASCII-only (wscript misreads non-ASCII, like the .ps1 convention).

Option Explicit
Dim sh, fso, scriptDir, ps1, cmd
Set sh  = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
ps1 = scriptDir & "\Sync-Widgets.ps1"
cmd = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & ps1 & """ -Target recruiter"
' 0 = hidden window, True = wait for exit. Pass the exit code through.
WScript.Quit sh.Run(cmd, 0, True)
