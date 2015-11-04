#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

yum_package %w[httpd wget] do 
	action :install
end

execute 'download_rpm' do
  cwd '/tmp'
#  user 'root'	
  command "wget #{node['apache']['modurl']}"
  not_if  {File.exist?(node['apache']['control'])}

end


rpm_package node['apache']['mod']  do	
 source "/tmp/#{node['apache']['mod']}"
 action :install

end

service 'httpd' do
  supports :restart => true, :reload => true
  action :enable

end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  mode '0644'
end

template '/etc/httpd/conf/workers.properties' do
  source 'workers.properties.erb'
  mode '0644'
end

service 'httpd' do
  supports :restart => true, :reload => true
  action :enable
end
