#
# Cookbook Name:: maven
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
bash 'maven' do
  cwd '/tmp'
  user 'root'	
  code <<-EOH

    wget #{node['maven'] ['url']}
    tar xzf #{node['maven'] ['dir']}-bin.tar.gz -C /usr/local

  EOH
	
  not_if { File.exists?("/tmp/apache-maven-3.0.5-bin.tar.gz")}


end

link '/usr/local/maven'  do
       to '/usr/local/apache-maven-3.0.5'
       link_type :symbolic 
      not_if { File.exists?("/usr/local/maven")}
end

cookbook_file '/etc/profile.d/maven.sh' do

  source 'maven.sh'
  mode '0755'
  action :create

not_if {File.exists?("/etc/profile.d/maven.sh")}

end
