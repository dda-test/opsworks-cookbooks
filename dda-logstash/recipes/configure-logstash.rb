ls_config_dir = "#{node[:logstash][:install_dir]}/#{node[:logstash][:base_name]}-#{node[:logstash][:version]}/config"
ls_config = "#{ls_config_dir}/logstash.conf"

directory "#{ls_config_dir}" do
	owner "#{node[:logstash][:user]}"
	group "#{node[:logstash][:group]}"
	mode 0755
	action :create
end

template "logstash config" do
	path ls_config
	source 'logstash.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
	notifies :reload, 'service[logstash]', :delayed
end

template "/etc/init.d/logstash" do
	source 'logstash.erb'
	owner 'root'
	group 'root'
	mode '0755'
	notifies :reload, 'service[logstash]', :delayed
end

group node[:logstash][:group] do
  action :create
  append true
end

user_home = "/#{node[:logstash][:user]}"

user node[:logstash][:user] do
  supports :manage_home => true
  gid node[:logstash][:group]
  shell '/bin/bash'
  home user_home
  system true
  action :create
end

directory node[:logstash][:pid_dir] do
	owner "#{node[:logstash][:user]}"
	group "#{node[:logstash][:group]}"
	mode 0755
	action :create
end

directory "#{node[:logstash][:install_dir]}/logs" do
	owner "#{node[:logstash][:user]}"
	group "#{node[:logstash][:group]}"
	mode 0755
	action :create
end

directory '/etc/pki/tls/private' do
	owner "#{node[:logstash][:user]}"
	group "#{node[:logstash][:group]}"
	mode 0755
	action :create
end

cookbook_file '/etc/pki/tls/private/logstash.key' do
	source 'logstash.key'
	owner "#{node[:logstash][:user]}"
	group "#{node[:logstash][:group]}"
	mode 0644
	action :create
end

directory '/etc/pki/tls/certs' do
	owner "#{node[:logstash][:user]}"
	group "#{node[:logstash][:group]}"
	mode 0755
	action :create
end

# NOTE:  logstash.crt was created 7/09/2015 and is valid for 365 days
# Command to create on logstash server:  
# openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout logstash.key -out logstash.crt -days 365
cookbook_file '/etc/pki/tls/certs/logstash.crt' do
	source 'logstash.key'
	owner "#{node[:logstash][:user]}"
	group "#{node[:logstash][:group]}"
	mode 0644
	action :create
end

include_recipe 'dda-logstash::service'

log "enabling logstash service"
service 'logstash' do
	action :enable
end

log "starting logstash service"
service 'logstash' do
	action :start
	not_if 'pgrep -lf logstash'
end
