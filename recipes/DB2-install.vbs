'
' Copyright 2013 Dean Okamura
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.
'
' creates "C:\Program Files\IBM\SQLLIB"
'

Option Explicit

Dim objFSO, objShell
Dim imaDirectory, db2Directory

imaDirectory = "C:\temp\ESE\image"
db2Directory = "C:\Program Files\IBM\SQLLIB"

Set objFSO = CreateObject("Scripting.FileSystemObject")

If objFSO.FolderExists(imaDirectory) Then
If Not objFSO.FolderExists(db2Directory) Then
    WScript.Echo "Install DB2"
    Set objShell = CreateObject("WScript.Shell")
    objShell.CurrentDirectory = imaDirectory
    objShell.Run "cmd /k setup -u C:\cookbooks\itmhost\recipes\db2ese.rsp"
    WScript.Echo "DB2 installation can take several minutes."
    WScript.Echo "Login as db2admin, then ..."
    WScript.Echo "Run " & db2Directory & "\BIN\db2val.exe to validate DB2 installation"
End If
End If

WScript.Quit

'
