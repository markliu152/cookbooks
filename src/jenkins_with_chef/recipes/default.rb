cookbook_file '/etc/yum.repos.d/jenkins.repo' do
  source 'jenkins.repo'
  mode '0755'
end

execute 'Jenkins_key' do
  command 'sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
  action :run
end

yum_package 'jenkins' do
  action :install
end

service 'jenkins' do
  action [:start, :enable]
end


