#
# Cookbook Name:: gitlab
# Recipe:: default
#
# Copyright 2015, Bogdan Sheptytsky
#
# All rights reserved - Do Not Redistribute

yum_package %w[curl wget openssh-server postfix cronie]  do
  action :install
  end


service 'postfix' do
  action :start
  end

#chckconfig

execute "postfix_enable_service" do
  command "chkconfig postfix on"
  end

# open standard ssh port
#  firewall_rule 'ssh' do
#    port     22
#    command  :allow
#   end
#
# open standard http port to tcp traffic only; insert as first rule
#  firewall_rule 'http' do
#     port     80
#     protocol :tcp
#     position 1
#     command   :allow
#   end
#

          
execute "firewall_add_rule" do
  command "lokkit -s http -s ssh"
  end

bash "Add_GitLab_Repo" do
  user 'root'
  code <<-EOH
    if  `yum -C repolist gitlab_gitlab-ce | grep -q "repolist: 0"` 
      then
        wget 'https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh' && chmod +x script.rpm.sh && ./script.rpm.sh
        rm -f script.rpm.sh
    fi
  EOH
end

# Instal GitLab
yum_package 'gitlab-ce'  do
  action :install
  end

# Gitlab Reconfigure
execute 'Gitlab-reconfigure' do
  command "gitlab-ctl reconfigure"
end

# Obtain Backup from my local machine
execute 'Obtain_Backup' do
  command "scp root@192.168.103.138:/home/gitlab-backups/$(ssh root@192.168.103.138 'ls -t /home/gitlab-backups/ | head -1') /var/opt/gitlab/backups"
end

# Recovery latest version of backup, located in backup directory
bash 'GitLab_Recovery_from_BackUp' do
  user 'root'
  code <<-EOH
    chown git: /var/opt/gitlab/backups/*
    gitlab-ctl stop unicorn
    gitlab-ctl stop sidekiq
    gitlab-rake gitlab:backup:restore BACKUP=$(ls -t /var/opt/gitlab/backups | head -1 | grep -Eo '[0-9]{1,10}')
    gitlab-ctl start
  EOH
end

