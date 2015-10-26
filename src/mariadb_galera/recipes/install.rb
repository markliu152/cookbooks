include_recipe 'mariadb_galera::hosts'
cookbook_file "/etc/yum.repos.d/mariadb.repo" do
  source "mariadb.repo"
  mode "0644"
end

package 'MariaDB-Galera-server' do
  action :install
end

package 'MariaDB-client' do
  action :install
end

package 'galera' do
  action :install
end

service 'mysql' do
  action [:enable, :start]
end


