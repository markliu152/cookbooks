yum_package 'epel-release' do 
  action :install
end

yum_package 'mysql-server >= 5' do 
  action :install
end

service 'mysqld' do
supports :status => true, :restart => true, :reload => true 
  action [:enable , :restart]
end
bash 'configure_mysql' do
  user 'root'
  code <<-EOH
mysql -u root -p -e "CREATE DATABASE #{node[:mysql][:dbase]} CHARACTER SET utf8 COLLATE utf8_general_ci;CREATE USER '#{node[:mysql][:user]}' IDENTIFIED BY '#{node[:mysql][:pass]}';GRANT ALL ON #{node[:mysql][:dbase]}.* TO '#{node[:mysql][:user]}'@'%' IDENTIFIED BY '#{node[:mysql][:pass]}';GRANT ALL ON #{node[:mysql][:dbase]}.* TO '#{node[:mysql][:user]}'@'localhost' IDENTIFIED BY '#{node[:mysql][:pass]}';FLUSH PRIVILEGES;" 
  EOH
not_if {File.exist?("/var/lib/mysql/sonar/db.opt")}

end
