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
' creates "C:\temp\base"
'

Option Explicit

Dim objFSO, objFolder, objShell, objSource, objTarget, objZip
Dim tempDirectory, tmvDirectory, baseDirectory, baseZipFile
Dim intOptions

tempDirectory = "C:\temp"
tmvDirectory = tempDirectory & "\base_windows64"
baseDirectory = tmvDirectory & "\WINDOWS"
baseZipFile = "Y:\tmv630fp2-d3204a-201307240013.base_windows64.zip"

Set objFSO = CreateObject("Scripting.FileSystemObject")

If Not objFSO.FolderExists(tempDirectory) Then
    WScript.Echo "Create " & tempDirectory
    Set objFolder = objFSO.CreateFolder(tempDirectory)
End If
If Not objFSO.FolderExists(tmvDirectory) Then
    WScript.Echo "Create " & tmvDirectory
    Set objFolder = objFSO.CreateFolder(tmvDirectory)
End If
If Not objFSO.FolderExists(baseDirectory) Then
    WScript.Echo "Extracting " & baseZipFile
    Set objShell = CreateObject("Shell.Application")
    Set objZip = objShell.NameSpace(baseZipFile)
    if objZip Is Nothing Then
        WScript.Echo baseZipFile & " not found"
    Else
        Set objSource = objZip.Items()
        Set objTarget = objShell.NameSpace(tmvDirectory)
        intOptions = 4

        WScript.Echo "Installation files in " & baseDirectory
        objTarget.CopyHere objSource, intOptions
    End If
End If

WScript.Quit

'
