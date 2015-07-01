es_config = "#{node[:elasticsearch][:install_dir]}/#{node[:elasticsearch][:base_name]}-#{node[:elasticsearch][:version]}/config/elasticsearch.yml"

template "elasticsearch config" do
	path es_config
	source 'elasticsearch.yml.erb'
	owner 'root'
	group 'root'
	mode '0644'
	notifies :reload, 'service[elasticsearch]', :delayed
end

template "/etc/init.d/elasticsearch" do
	source 'elasticsearch.erb'
	owner 'root'
	group 'root'
	mode '0755'
	notifies :reload, 'service[elasticsearch]', :delayed
end

group node[:elasticsearch][:group] do
  action :create
  append true
end

user_home = "/#{node[:elasticsearch][:user]}"

user node[:elasticsearch][:user] do
  supports :manage_home => true
  gid node[:elasticsearch][:group]
  shell '/bin/bash'
  home user_home
  system true
  action :create
end

include_recipe 'dda-elasticsearch::service'

service 'elasticsearch' do
	action :start
	not_if 'pgrep -lf elasticsearch'
end