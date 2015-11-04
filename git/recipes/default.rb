#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package %w[curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker] do
  action :install
end

package 'git' do
  action :remove
end

bash 'extract_git' do
  user 'root'
  cwd '/usr/src'
  code <<-EOH
    wget #{node['git']['url']}  
    tar xzf #{node['git']['arch']}
    cd #{node['git']['dir']}
    make prefix=/usr/local/git all
    make prefix=/usr/local/git install
    echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc
    source /etc/bashrc  
    EOH
  not_if {File.exists?("/usr/src/#{node['git']['arch']}") }
end

