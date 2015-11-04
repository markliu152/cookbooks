#
# Cookbook Name:: java-1.7
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

yum_package %w[wget tar] do 

	action :install
end


bash 'install_java' do
  user 'root'
  cwd '/opt'
  code <<-EOH

	 wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" #{node['java-1.7']['url']}
	 tar zxf #{node['java-1.7']['arch']}
  	 
 EOH
not_if {File.exist?("opt/#{node['java-1.7']['arch']}")}

 end

bash 'configure_java' do
  user 'root'
  cwd #{node['java-1.7']['dir']}
  code <<-EOH

	alternatives --install /usr/bin/java java #{node['java-1.7']['dir']}/bin/java 1
	alternatives --install /usr/bin/jar jar #{node['java-1.7']['dir']}/bin/jar 1
	alternatives --install /usr/bin/javac javac #{node['java-1.7']['dir']}/bin/javac 1 
	alternatives --set jar #{node['java-1.7']['dir']}/bin/jar
	alternatives --set javac #{node['java-1.7']['dir']}/bin/javac
EOH

 end

cookbook_file '/etc/profile.d/java.sh' do
  source 'java.sh'
  owner 'root'
  mode '0755'
not_if {File.exist?('/etc/profile.d/java.sh')}
end


script 'myruby' do 
  interpreter 'ruby'
  user 'root'
  code <<-EOH
  exec("source '/etc/profile.d/java.sh'")
  exec("su para -c 'source /etc/profile.d/java.sh'")
  EOH
end	
