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

link "/home/vagrant/etc" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/etc"
end

link "/home/vagrant/tms630fp2" do
    owner "vagrant"
    group "vagrant"
    to "/Users/dokamura/tms630fp2"
end

yum_package "git" do
  action :install
end

yum_package "mksh" do
  action :install
end
