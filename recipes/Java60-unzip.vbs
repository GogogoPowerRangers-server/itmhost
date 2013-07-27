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
' creates C:\Program Files\Java60\jre\bin
'

Option Explicit

Dim objFSO, objFolder, objShell, objSource, objTarget
Dim ibmDirectory, jdkDirectory, jreDirectory, jreZipFile
Dim intOptions

ibmDirectory = "C:\Program Files\IBM"
jdkDirectory = ibmDirectory & "\Java60"
jreDirectory = jdkDirectory & "\jre"
jreZipFile = "C:\vagrant\ibm-java-jre-60-win-x86_64.zip"

Set objFSO = CreateObject("Scripting.FileSystemObject")

If Not objFSO.FolderExists(ibmDirectory) Then
    WScript.Echo "Create " & ibmDirectory
    Set objFolder = objFSO.CreateFolder(ibmDirectory)
End If
If Not objFSO.FolderExists(jdkDirectory) Then
    WScript.Echo "Create " & jdkDirectory
    Set objFolder = objFSO.CreateFolder(jdkDirectory)
End If

If Not objFSO.FolderExists(jreDirectory) Then
    WScript.Echo "Extracting " & jreZipFile
    Set objShell = CreateObject("Shell.Application")
    Set objSource = objShell.NameSpace(jreZipFile).Items()
    Set objTarget = objShell.NameSpace(jdkDirectory)
    intOptions = 4

    WScript.Echo "Installing in " & jdkDirectory
    objTarget.CopyHere objSource, intOptions
End If

WScript.Quit

'
