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

mkdir C:\temp\chef
mkdir C:\temp\chef\databags

if EXIST C:\chef\cookbooks\itmhost goto :fi_cookbooks
    @echo C:\chef\cookbooks\itmhost is missing
    goto :done
:fi_cookbooks

@REM cygwin.rb needs a little setup
if EXIST C:\vagrant goto :fi_setup
    mkdir C:\vagrant
    copy chef-run.bat C:\vagrant
    copy node.json C:\vagrant
    copy solo.rb C:\vagrant
    copy ssh-host-config C:\vagrant
:fi_setup

@echo Installing Cygwin
chef-solo -c C:\vagrant\solo.rb -j C:\vagrant\node.json

:done
@endlocal
:EOF
