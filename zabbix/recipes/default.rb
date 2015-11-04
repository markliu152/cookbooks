#
# Cookbook Name:: zabbix
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

yum_package 'zabbix-server-mysql = 2.2.2-1.el6' do 

  action :install

end

yum_package 'zabbix-web-mysql >= 2.2' do

  action :install

end
yum_package 'zabbix-agent = 2.2.2-1.el6' do

  action :install
end

include_recipe 'zabbix::mysql'


template '/etc/zabbix/zabbix_server.conf' do 

source 'zabbix_server.conf.erb'

end

template '/etc/httpd/conf.d/zabbix.conf' do

source 'zabbix.conf.erb'

end
