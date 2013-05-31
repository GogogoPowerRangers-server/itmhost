#
# Licensed Materials - Property of IBM
#
# 2013-IBM
#
# (C) Copyright IBM Corp. 2013    All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with
# IBM Corp.
#
include_recipe 'resolver'

execute "git user" do
    command "printf '[user]\n    name = Dean Okamura\n    email = dokamura@us.ibm.com\n' >> /home/vagrant/.gitconfig"
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

yum_package "gdb" do
  action :install
end

yum_package "git" do
  action :install
end

yum_package "mksh" do
  action :install
end

# Minimal ITM
directory "/opt/IBM" do
  owner "root"
  mode "0755"
  action :create
end

directory "/opt/IBM/ITM" do
  owner "vagrant"
  mode "0775"
  action :create
end

# Download from AUSGSA or Dropbox
remote_file "/vagrant/centos-64-x64-itm-lite.tar.gz" do
  # AUSGSA
  source "https://ausgsa.ibm.com/home/d/o/dokamura/web/public/centos-64-x64-itm-lite.tar.gz"
  # Dropbox
  # source "https://dl.dropboxusercontent.com/u/20692025/centos-64-x64-itm-lite.tar.gz"
  action :create_if_missing
  mode "0744"
  owner "vagrant"
  group "vagrant"
end

execute "extract Minimal ITM" do
  command "cd /opt/IBM; tar -zxvf /vagrant/centos-64-x64-itm-lite.tar.gz; chown -R vagrant:vagrant /opt/IBM/ITM"
  not_if { ::File.exists?("/opt/IBM/ITM/bin")}
end

