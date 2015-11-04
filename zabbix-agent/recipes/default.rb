#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
bash 'install_rpmrepo' do
  code <<-EOH
  rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm
  EOH
  not_if {File.exist?('/etc/yum.repos.d/zabbix.repo')}
end


yum_package 'zabbix-agent >= 2.2' do

  action :install
end

template '/etc/zabbix/zabbix_agentd.conf' do 
  source 'zabbix_agentd.conf.erb'
end

service 'zabbix-agent' do 
  action [:enable, :start]
end
