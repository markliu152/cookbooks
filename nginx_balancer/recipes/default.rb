#
# Cookbook Name:: nginx_balancer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
#


	package 'nginx' do
		action :install
	end

	service 'nginx' do
		supports :restart => true, :status => true, :reload => true
		action [ :enable, :start ]
	end


