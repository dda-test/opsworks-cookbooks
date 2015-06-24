default[:kapow] = {}
default[:kapow][:install_dir] = '/mnt/ebs/kapow'
default[:kapow][:download_dir] = '/mnt/ebs/kapow/download'
default[:kapow][:base_name] = 'KapowKatalyst'
default[:kapow][:version] = '9.4.8'
default[:kapow][:architecture] = 'x64'
default[:kapow][:ext] = 'gz'
default[:kapow][:archive_name] = "#{node[:kapow][:base_name]}_#{node[:kapow][:version]}_#{node[:kapow][:architecture]}.#{node[:kapow][:ext]}"
default[:kapow][:s3_bucket] = 'dodge-dev-opsworks/software-deployments'
default[:kapow][:server_port] = '50000'
default[:kapow][:cmd_robotserver] = "#{node[:kapow][:install_dir]}/#{node[:kapow][:base_name]}_#{node[:kapow][:version]}_#{node[:kapow][:architecture]}/bin/RoboServer -p #{node[:kapow][:server_port]} & disown"
default[:kapow][:cmd_mgtconsole] = "#{node[:kapow][:install_dir]}/#{node[:kapow][:base_name]}_#{node[:kapow][:version]}_#{node[:kapow][:architecture]}/bin/RoboServer -p #{node[:kapow][:server_port]} -MC & disown"
