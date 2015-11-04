#
# Cookbook Name:: sonarqube
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'sonarqube::mysql'

yum_package 'wget' do
  action :install
end

execute 'install_repo' do
  user 'root'
  command 'wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo'
  not_if {File.exist?("/etc/yum.repos.d/sonar.repo")}
end

yum_package 'sonar' do
  action :install
end

template '/opt/sonar/conf/sonar.properties' do
  source 'sonar.properties.erb'
end

yum_package 'httpd' do 
  action :install
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
end

cookbook_file '/etc/init.d/sonar' do
  source 'sonar'
  mode '0755'
  action :create
end

template '/opt/sonar/conf/wrapper.conf' do
  source 'wrapper.conf.erb'
end
link '/opt/sonar//bin/linux-x86-32/sonar.sh' do
  to '/usr/bin/sonar'
end

service 'sonar' do
  action [:start, :enable]
end

service 'httpd' do
  action :restart
end

