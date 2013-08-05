@ECHO OFF
@REM
@REM Copyright 2013 Dean Okamura
@REM
@REM Licensed under the Apache License, Version 2.0 (the "License");
@REM you may not use this file except in compliance with the License.
@REM You may obtain a copy of the License at
@REM
@REM     http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing, software
@REM distributed under the License is distributed on an "AS IS" BASIS,
@REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM See the License for the specific language governing permissions and
@REM limitations under the License.
@REM

@setlocal

if EXIST C:\vagrant\setup-x86_64.exe goto :fi_download
    @echo Download setup-x86_64.exe
    cscript /nologo C:\vagrant\wget.vbs http://www.cygwin.com/setup-x86_64.exe C:\vagrant\setup-x86_64.exe
    if NOT EXIST C:\vagrant\setup-x86_64.exe goto :done
:fi_download

if EXIST C:\cygwin64\bin\bash.exe goto :fi_bash
    @echo Install Cygwin
    @REM mirror.mcs.anl.gov
    C:\vagrant\setup-x86_64.exe -q -D -s http://mirrors.xmission.com/cygwin -l C:\vagrant -L C:\cygwin -P binutils,gcc-g++,inetutils,make,openssh,python,rsync,vim,zip,unzip
    if NOT EXIST C:\cygwin64\bin\mkpasswd.exe goto :done
:fi_bash

if EXIST C:\cygwin64\etc\passwd goto :fi_passwd
    @echo /etc/passwd
    C:\cygwin64\bin\mkpasswd.exe -l > C:\cygwin64\etc\passwd
:fi_passwd

if EXIST C:\cygwin64\etc\group goto :fi_group
    @echo /etc/group
    C:\cygwin64\bin\mkgroup.exe -l > C:\cygwin64\etc\group
:fi_group

if EXIST C:\cygwin64\home\%USERNAME% goto :fi_home
    @echo /home/%USERNAME%
    mkdir C:\cygwin64\home\%USERNAME%
:fi_home

if EXIST C:\cygwin64_done goto :fi_sshd
    @echo Install sshd
    C:\cygwin64\bin\bash.exe --login -c '/cygdrive/c/vagrant/ssh-host-config -y -w v8a8grant'
:fi_sshd

if EXIST C:\cygwin64_done goto :fi_port_22
    @echo Open port 22
    netsh advfirewall firewall add rule name=SSH dir=in action=allow protocol=tcp localport=22
:fi_port_22

if EXIST C:\cygwin64_done goto :fi_sshd_started
    @echo Start sshd
    net start sshd
:fi_sshd_started

find "C:/Users" C:\cygwin64\etc\fstab
if "%ERRORLEVEL%" == "0" goto :fi_Users
    echo >> C:\cygwin64\etc\fstab C:/Users /Users ntfs text,posix=0 0 0
    C:\cygwin64\bin\mount -a
:fi_Users

if EXIST C:\cygwin64\tmp\passwd.backup goto :fi_passwd
    copy C:\cygwin64\etc\passwd C:\cygwin64\tmp\passwd.backup
    C:\cygwin64\bin\sed.exe "s#/home/#/Users/#" < C:\cygwin64\tmp\passwd.backup > C:\cygwin64\etc\passwd
:fi_passwd

:done
@endlocal
:EOF
