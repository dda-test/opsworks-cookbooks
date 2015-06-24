execute "update proxy passing to use kapow mgt console port" do
	environment "PATH" => "/bin:#{ENV["PATH"]}"
	command "sed -i 's/^\\(Proxy.*:\\)\\(8080\\)\\(\\/\\)$/\\150080\\3/g' /etc/httpd/conf/httpd.conf"
	notifies :reload, "service[apache2]", :delayed
end

execute "run management console" do
  user "root"
  group "root"
#  command "#{node[:kapow][:cmd_mgtconsole]}"
  command "/mnt/ebs/kapow/KapowKatalyst_9.4.8_x64/bin/RoboServer -p 50000 & disown"
  not_if "pgrep -lf RoboServer"
end
