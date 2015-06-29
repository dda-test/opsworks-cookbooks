directory node[:kibana][:install_dir] do
	owner "root"
	group "root"
	mode 0755
	action :create
end

execute "download package" do
  environment "PATH" => "/usr/bin:#{ENV["PATH"]}"
  cwd "#{node[:kibana][:install_dir]}"
  command "wget -q https://s3.amazonaws.com/#{node[:kibana][:s3_bucket]}/#{node[:kibana][:archive_name]}"
  not_if { ::File.exist?("#{node[:kibana][:install_dir]}/#{node[:kibana][:archive_name]}")}
end

execute "untar package" do
  environment "PATH" => "/bin:#{ENV["PATH"]}"
  cwd "#{node[:kibana][:install_dir]}"
  command "tar -zxf #{node[:kibana][:install_dir]}/#{node[:kibana][:archive_name]}"
  not_if { ::File.exist?("#{node[:kibana][:install_dir]}/#{node[:kibana][:base_name]}-#{node[:kibana][:version]}-#{node[:kibana][:architecture]}")}
end