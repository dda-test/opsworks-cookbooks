directory node[:logstash][:install_dir] do
	owner "root"
	group "root"
	mode 0755
	action :create
end

execute "download package" do
  environment "PATH" => "/usr/bin:#{ENV["PATH"]}"
  cwd "#{node[:logstash][:install_dir]}"
  command "wget -q https://s3.amazonaws.com/#{node[:logstash][:s3_bucket]}/#{node[:logstash][:archive_name]}"
  not_if { ::File.exist?("#{node[:logstash][:install_dir]}/#{node[:logstash][:archive_name]}")}
end

execute "untar package" do
  environment "PATH" => "/bin:#{ENV["PATH"]}"
  cwd "#{node[:logstash][:install_dir]}"
  command "tar -zxf #{node[:logstash][:install_dir]}/#{node[:logstash][:archive_name]}"
  not_if { ::File.exist?("#{node[:logstash][:install_dir]}/#{node[:logstash][:base_name]}-#{node[:logstash][:version]}")}
end