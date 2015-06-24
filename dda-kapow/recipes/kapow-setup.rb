directory node[:kapow][:install_dir] do
	owner "root"
	group "root"
	mode 0755
	action :create
end

execute "download package" do
  environment "PATH" => "/usr/bin:#{ENV["PATH"]}"
  cwd "#{node[:kapow][:install_dir]}"
  command "wget -q https://s3.amazonaws.com/#{node[:kapow][:s3_bucket]}/#{node[:kapow][:archive_name]}"
  not_if { ::File.exist?("#{node[:kapow][:install_dir]}/#{node[:kapow][:archive_name]}")}
end

execute "untar package" do
  environment "PATH" => "/bin:#{ENV["PATH"]}"
  cwd "#{node[:kapow][:install_dir]}"
  command "tar -zxf #{node[:kapow][:install_dir]}/#{node[:kapow][:archive_name]}"
  not_if { ::File.exist?("#{node[:kapow][:install_dir]}/#{node[:kapow][:base_name]}_#{node[:kapow][:version]}_#{node[:kapow][:architecture]}")}
end

