directory node[:elasticsearch][:install_dir] do
	owner "root"
	group "root"
	mode 0755
	action :create
end

execute "download package" do
  environment "PATH" => "/usr/bin:#{ENV["PATH"]}"
  cwd "#{node[:elasticsearch][:install_dir]}"
  command "wget -q https://s3.amazonaws.com/#{node[:elasticsearch][:s3_bucket]}/#{node[:elasticsearch][:archive_name]}"
  not_if { ::File.exist?("#{node[:elasticsearch][:install_dir]}/#{node[:elasticsearch][:archive_name]}")}
end

execute "untar package" do
  environment "PATH" => "/bin:#{ENV["PATH"]}"
  cwd "#{node[:elasticsearch][:install_dir]}"
  command "tar -zxf #{node[:elasticsearch][:install_dir]}/#{node[:elasticsearch][:archive_name]}"
  not_if { ::File.exist?("#{node[:elasticsearch][:install_dir]}/#{node[:elasticsearch][:base_name]}-#{node[:elasticsearch][:version]}")}
end