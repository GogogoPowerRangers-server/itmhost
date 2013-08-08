#
# Copyright 2013 Dean Okamura
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# Use Powershell ...
#
# Powershell -ExecutionPolicy Unrestricted Z:\base-unzip.ps1
#
# ... Choose "R" to run script

$baseZipFile = 'Y:\tmv630fp2-d3204a-201307240013.base_windows64.zip'
$tmvDirectory = 'C:\temp\base_windows64'
mkdir $tmvDirectory

[System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem')
[System.IO.Compression.ZipFile]::ExtractToDirectory($baseZipFile, $tmvDirectory)

#
