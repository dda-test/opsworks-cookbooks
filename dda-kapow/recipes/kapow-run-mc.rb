execute "update proxy passing to use kapow mgt console port" do
	environment "PATH" => "/bin:#{ENV["PATH"]}"
	command "sed -i 's/^\\(Proxy.*:\\)\\(8080\\)\\(\\/\\)$/\\150080\\3/g' /etc/httpd/conf/httpd.conf"
end

bash "run management console" do
  code "#{node[:kapow][:cmd_mgtconsole]}"
  not_if "pgrep -lf RoboServer"
end
