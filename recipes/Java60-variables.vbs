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
' creates C:\temp\JAVA_HOME
'

Option Explicit

Dim objFSO, objShell, objSystem
Dim ibmDirectory, jdkDirectory, jreDirectory, tempDirectory

tempDirectory = "C:\temp"
ibmDirectory = "C:\Program Files\IBM"
jdkDirectory = ibmDirectory & "\Java60"
jreDirectory = jdkDirectory & "\jre"

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = WScript.CreateObject("WScript.Shell")
Set objSystem = objShell.Environment("System")

If Not objFSO.FolderExists(tempDirectory) Then
    WScript.Echo "Create " & tempDirectory
    Set objFolder = objFSO.CreateFolder(tempDirectory)
End If
If objSystem("JAVA_HOME") = "" Then
    WScript.Echo "Setting JAVA_HOME to " & jdkDirectory
    objSystem("JAVA_HOME") = jdkDirectory
    WScript.Echo "Setting JRE_HOME to " & jreDirectory
    objSystem("JRE_HOME") = jreDirectory
    WScript.Echo "Setting PATH"
    objSystem("PATH") = objSystem("PATH") & ";" & jreDirectory & "\bin"
End If
WScript.Echo "Create " & tempDirectory & "\JAVA_HOME"
Set objFile = objFSO.CreateTextFile(tempDirectory & "\JAVA_HOME")

WScript.Quit

'
