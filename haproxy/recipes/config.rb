include_recipe 'haproxy::install' 

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.erb'
  notifies :restart ,'service[haproxy]'
end

service 'haproxy' do
  action :nothing
end
