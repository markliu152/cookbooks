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
mysql -u root -p -e "CREATE DATABASE #{node[:zabbix][:dbase]} CHARACTER SET utf8 COLLATE utf8_general_ci;CREATE USER '#{node[:zabbix][:user]}' IDENTIFIED BY '#{node[:zabbix][:pass]}';GRANT ALL ON #{node[:zabbix][:dbase]}.* TO '#{node[:zabbix][:user]}'@'localhost' IDENTIFIED BY '#{node[:zabbix][:pass]}';FLUSH PRIVILEGES;"
  EOH
not_if {File.exist?("/var/lib/mysql/zabbix/db.opt")}

end




#bash 'create_datbeses' do
#  user 'root'
#  code <<-EOH
#mysql -u root zabbix < /usr/share/doc/zabbix-server-mysql-2.2.9/create/schema.sql
#mysql -u root zabbix < /usr/share/doc/zabbix-server-mysql-2.2.9/create/images.sql
#mysql -u root zabbix < /usr/share/doc/zabbix-server-mysql-2.2.9/create/data.sql
#  EOH
#not_if {File.exist?("/usr/share/doc/zabbix-server-mysql/create/data.sql")}

#end
