#
# Cookbook Name:: deploy
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

git '/home/para/Lv-164-DevOps' do
  repository 'git@192.168.103.191:root/Lv-164-DevOps.git'
  revision 'master'
  action :sync	
  user 'para'
end 

bash 'build' do
  user 'root'
  cwd '/home/para/Lv-164-DevOps'
  code <<-EOH
mvn  clean package -DskipTests 
  EOH
not_if {::File.exist?('/home/para/Lv-164-DevOps/target/abc.war')}

end


bash 'build' do
code <<-EOH
cp /home/para/Lv-164-DevOps/target/abc.war /usr/local/tomcat7/apache-tomcat-7.0.64/webapps/ROOT.war
sshpass -p 'password' scp /home/para/Lv-164-DevOps/target/abc.war  root@192.168.103.164:/usr/local/tomcat7/apache-tomcat-7.0.64/webapps/ROOT.war
 EOH
end
