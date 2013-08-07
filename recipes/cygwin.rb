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

directory "C:\\vagrant" do
    mode 0775
    action :create
end

remote_file "C:\\vagrant\\setup-x86_64.exe" do
    source "http://www.cygwin.com/setup-x86_64.exe"
end


# Install Cygwin
execute "Install Cygwin" do
  command "C:\\vagrant\\setup-x86_64.exe -q -D -s http://mirrors.xmission.com/cygwin -l C:\\vagrant -L C:\\cygwin -P binutils,curl,gcc-g++,inetutils,make,openssh,python,rsync,vim,zip,unzip"
  not_if { ::File.exists?("C:\\cygwin64\\bin\\bash.exe")}
end

# Create system files
execute "/etc/passwd" do
  command "C:\\cygwin64\\bin\\mkpasswd.exe -l > C:\\cygwin64\\etc\\passwd"
  not_if { ::File.exists?("C:\\cygwin64\\etc\\passwd")}
end

execute "/etc/group" do
  command "C:\\cygwin64\\bin\\mkgroup.exe -l > C:\\cygwin64\\etc\\group"
  not_if { ::File.exists?("C:\\cygwin64\\etc\\group")}
end

execute "/home directory" do
  command "mkdir C:\\cygwin64\\home\\%USERNAME%"
  not_if { ::File.exists?("C:\\cygwin64\\home\\" + ENV['USERNAME'])}
end

# Mount C:\Users
execute "Mount C:\\Users" do
  command "echo >> C:\\cygwin64\\etc\\fstab C:/Users /Users ntfs text,posix=0 0 0 && C:\\cygwin64\\bin\\mount -a && echo > C:\\cygwin64\\tmp\\fstab_done done"
  not_if { ::File.exists?("C:\\cygwin64\\tmp\\fstab_done")}
end

# Change to C:\Users for home directories
execute "Change to C:\Users for home directories" do
  command "copy C:\\cygwin64\\etc\\passwd C:\\cygwin64\\tmp\\passwd.backup && C:\\cygwin64\\bin\\sed.exe 's#/home/#/Users/#' < C:\\cygwin64\\tmp\\passwd.backup > C:\\cygwin64\\etc\\passwd"
  not_if { ::File.exists?("C:\\cygwin64\\tmp\\passwd.backup")}
end

# Install sshd
execute "Install sshd" do
  command "C:\\cygwin64\\bin\\bash.exe --login -c '/cygdrive/c/vagrant/ssh-host-config -y -w v8a8grant'"
end

# Open port 22
execute "Open port 22" do
  command "netsh advfirewall firewall add rule name=SSH dir=in action=allow protocol=tcp localport=22"
end

# Start sshd
execute "Start sshd" do
  command "net start sshd"
end

#
