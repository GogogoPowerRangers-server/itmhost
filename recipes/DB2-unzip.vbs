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
' creates "C:\temp\ESE"
'

Option Explicit

Dim objFSO, objFolder, objShell, objSource, objTarget
Dim tempDirectory, db2Directory, db2ExeFile, db2ZipFile
Dim intOptions

tempDirectory = "C:\temp"
db2Directory = tempDirectory & "\ESE"
db2ExeFile = "C:\vagrant\DB2_ESE_10_Win_x86-64.exe"
db2ZipFile = "C:\vagrant\DB2_ESE_10_Win_x86-64.zip"

Set objFSO = CreateObject("Scripting.FileSystemObject")

If Not objFSO.FolderExists(tempDirectory) Then
    WScript.Echo "Create " & tempDirectory
    Set objFolder = objFSO.CreateFolder(tempDirectory)
End If
If Not objFSO.FolderExists(db2Directory) Then
    WScript.Echo "Renaming to " & db2ZipFile
    objFSO.MoveFile db2ExeFile, db2ZipFile
    WScript.Echo "Extracting " & db2ZipFile
    Set objShell = CreateObject("Shell.Application")
    Set objSource = objShell.NameSpace(db2ZipFile).Items()
    Set objTarget = objShell.NameSpace(tempDirectory)
    intOptions = 4

    WScript.Echo "Installation files in " & db2Directory
    objTarget.CopyHere objSource, intOptions

    WScript.Echo "Renaming to " & db2ExeFile
    objFSO.MoveFile db2ZipFile, db2ExeFile
End If

WScript.Quit

'
