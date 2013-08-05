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
' Set cyg_server password.
' When ssh-host-config does not complete successfully,
' setting the cyg_server password may fix the service startup error.
' You may need to use Windows Services to set service password.
'

Option Explicit

Dim objUser, strComputerName, wshShell

Set wshShell = WScript.CreateObject("WScript.Shell")
strComputerName = wshShell.ExpandEnvironmentStrings("%COMPUTERNAME%")
Set objUser = GetObject("WinNT://" & strComputerName & "/cyg_server")
objUser.SetPassword("v8a8grant")

'
