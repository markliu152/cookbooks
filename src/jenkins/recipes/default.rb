#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
bash 'download_jenkins' do
  user 'root'
  code <<-EOH
    wget -O #{node['jen']['repo']} #{node['jen']['url']}
    rpm --import #{node['jen']['key']}
    EOH
  not_if {File.exists?(node['jen']['repo'])}

end

yum_package 'jenkins' do 

action :install


end

service 'jenkins' do

action [ :enable , :start]

end
