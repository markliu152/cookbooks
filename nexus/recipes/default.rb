#
# Cookbook Name:: nexus
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute


yum_package %w[wget tar passwd] do
  action :install
end



bash 'extract_module' do
  cwd '/tmp'
  code <<-EOH
    wget "#{node[:nexus][:url]}"
    tar -xzf  #{node[:nexus][:arch]} -C /usr/local/
    EOH
  not_if {File.exists?('/tmp/nexus-latest-bundle.tar.gz')}
end

link '/usr/local/nexus' do
  to '/usr/local/nexus-2.11.4-01/'
  owner 'nexus'
  group 'nexus'
end

user 'nexus' do
  supports :manage_home => true
  uid '1234'
  home '/home/nexus'
  shell '/bin/bash'
  password '123'
end


bash 'extract_module' do
  cwd '/usr/local'
  code <<-EOH
   chown -R nexus:nexus sonatype-work/
   chown  nexus:nexus nexus
   chown -R nexus:nexus nexus-2.11.4-01/
    EOH
end

template '/usr/local/nexus-2.11.4-01/bin/nexus' do

source 'nexus.erb'

end
