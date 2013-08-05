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

# Windows base box must include vagrant user and chef-solo.

directory "C:\\temp" do
    owner "vagrant"
    group "vagrant"
    mode 0775
    action :create
end

# Java 6 installation
execute "Java 6 installation" do
  command "cscript /nologo " + File.dirname(__FILE__) + "\\Java60-unzip.vbs"
  not_if { ::File.exists?("C:\\Program Files\\Java60\\bin")}
end

execute "Java 6 system variables" do
  command "cscript /nologo " + File.dirname(__FILE__) + "\\Java60-variables.vbs"
  not_if { ::File.exists?("C:\\temp\\JAVA_HOME")}
end

# DB2 installation
execute "DB2 installation files" do
  command "cscript /nologo " + File.dirname(__FILE__) + "\\DB2-unzip.vbs"
  not_if { ::File.exists?("C:\\temp\\ESE")}
end

execute "DB2 install" do
  command "cscript /nologo " + File.dirname(__FILE__) + "\\DB2-install.vbs"
  not_if { ::File.exists?("C:\\Program Files\\IBM\\SQLLIB")}
end

#
