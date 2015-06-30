template "#{node['dda-elasticsearch']['install_dir']}/#{node[:elasticsearch][:base_name]}-#{node[:elasticsearch][:version]}/config/elasticsearch.yml" do
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

include_recipe 'dda-elasticsearch::service'

service 'elasticsearch' do
	action :start
	not_if 'pgrep -lf elasticsearch'
end