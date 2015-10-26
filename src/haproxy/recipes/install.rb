package 'haproxy' do
  action :install
end

service 'haproxy' do
  action :start
end
