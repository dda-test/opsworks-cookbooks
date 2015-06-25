execute "update proxy passing to use kapow mgt console port" do
	environment "PATH" => "/bin:#{ENV["PATH"]}"
	command "sed -i 's/^\\(Proxy.*:\\)\\(8080\\)\\(\\/\\)$/\\150080\\3/g' /etc/httpd/conf/httpd.conf"
	notifies :restart, 'service[apache2]', :delayed
end

execute "run management console" do
  user "root"
  group "root"
  command "#{node[:kapow][:cmd_robotserver]}"
end
