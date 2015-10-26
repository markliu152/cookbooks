include_recipe 'mariadb_galera::install'

execute 'create_cluster_user' do
  command "mysql -uroot <<< \"GRANT ALL PRIVILEGES ON *.* TO 'cluster'@'%' IDENTIFIED BY 'pass' WITH GRANT OPTION;FLUSH PRIVILEGES;\" && echo \"user created\" >> /opt/cluster_user.txt"
  creates '/opt/cluster_user.txt'
end

template '/etc/my.cnf.d/server.cnf' do
  source 'servers.erb'
  notifies :restart, "service[mysql]"
end

execute 'cluster_bootstrap' do
  command './etc/init.d/mysql bootstrap'
  only_if {node[:hostname] == 'mariadb1'}
end

service 'mysql' do
  action :nothing 
  only_if {node[:hostname] != 'mariadb1'}
end

