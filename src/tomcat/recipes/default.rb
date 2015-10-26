#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
bash 'extract_tom' do
  cwd '/tmp'
  code <<-EOH

    mkdir #{node['tom']['dir']}
    wget #{node['tom']['url']}
    tar xzf #{node['tom']['arch']} -C #{node['tom']['dir']}

    EOH

  not_if {File.exists?('/tmp/apache-tomcat-7.0.64.tar.gz')}

end

template "#{node['tom']['dir']}/apache-tomcat-7.0.64/conf/tomcat-users.xml" do  

  mode '0755'
  source 'tomcat-users.xml.erb'

end

execute 'run_tom' do
 
command "#{node['tom']['dir']}/apache-tomcat-7.0.64/bin/startup.sh"

end

template "#{node['tom']['dir']}/apache-tomcat-7.0.64/conf/server.xml" do

  mode '0755'
  source 'server.xml.erb'

end

execute 'stop_tom' do

command "#{node['tom']['dir']}/apache-tomcat-7.0.64/bin/shutdown.sh"

end

execute 'run_tom' do

command "#{node['tom']['dir']}/apache-tomcat-7.0.64/bin/startup.sh"

end

