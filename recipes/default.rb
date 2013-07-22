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
include_recipe 'resolver'

# Temporary: AWS seems to work with root user; Create vagrant account
group "vagrant" do
  action :create
end
user "vagrant" do
  comment "Random User"
  gid "vagrant"
  home "/home/vagrant"
  shell "/bin/bash"
  password "vagrant"
end
group "wheel" do
  action :modify
  members "vagrant"
  append true
end

execute "git user" do
    command "printf '[user]\n" +
                    "    name = vagrant\n" +
                    "    email = vagrant@us.ibm.com\n'" +
            " >> /home/vagrant/.gitconfig"
    creates "/home/vagrant/.gitconfig"
end

directory "/home/vagrant/temp" do
    owner "vagrant"
    group "vagrant"
    mode 0775
    action :create
end

link "/home/vagrant/cmvc" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/cmvc"
end

link "/home/vagrant/bin" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/bin"
end

link "/home/vagrant/tms630fp2" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/tms630fp2"
end

yum_package "compat-libstdc++-33" do
  action :install
end

yum_package "gdb" do
  action :install
end

yum_package "git" do
  action :install
end

yum_package "ksh" do
  action :install
end

yum_package "rsync" do
  action :install
end

yum_package "pam-devel" do
  action :install
end

yum_package "unzip" do
  action :install
end

# Minimal ITM
directory "/opt/IBM" do
  owner "root"
  mode "0755"
  action :create
end

# ITM Lite environment variables
# execute "ITM Lite environment variables" do
#   command "cp /vagrant/itmlite.sh /etc/profile.d/itmlite.sh"
#   creates "/etc/profile.d/itmlite.sh"
# end

# ITM Lite Download from AUSGSA or Dropbox
remote_file "/vagrant/ITM-lite-6.3.0-2.el6.x86_64.rpm" do
  # AUSGSA
  source "https://ausgsa.ibm.com/home/d/o/dokamura/web/public/ITM-lite-6.3.0-2.el6.x86_64.rpm"
  # AWS S3
  source "https://s3.amazonaws.com/dokamura/itmhost/ITM-lite-6.3.0-2.el6.x86_64.rpm"
  action :create_if_missing
  mode "0744"
  owner "vagrant"
  group "vagrant"
end

execute "Minimal ITM" do
  command "rpm -e ITM-lite-6.3.0-2.el6.x86_64; rpm -i /vagrant/ITM-lite-6.3.0-2.el6.x86_64.rpm; chown -R vagrant:vagrant /opt/IBM/ITM"
  not_if { ::File.exists?("/opt/IBM/ITM/bin")}
end
