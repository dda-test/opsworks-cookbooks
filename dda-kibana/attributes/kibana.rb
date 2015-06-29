default[:kibana] = {}
default[:kibana][:install_dir] = '/mnt/ebs/kibana'
default[:kibana][:base_name] = 'kibana'
default[:kibana][:version] = '4.1.0'
default[:kibana][:ext] = 'tar.gz'
default[:kibana][:archive_name] = "#{node[:kibana][:base_name]}-#{node[:kibana][:version]}.#{node[:kibana][:ext]}"
default[:kibana][:s3_bucket] = 'dodge-dev-opsworks/software-deployments'
