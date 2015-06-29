default[:elasticsearch] = {}
default[:elasticsearch][:install_dir] = '/mnt/ebs/elasticsearch'
default[:elasticsearch][:base_name] = 'elasticsearch'
default[:elasticsearch][:version] = '1.6.0'
default[:elasticsearch][:ext] = 'tar.gz'
default[:elasticsearch][:archive_name] = "#{node[:elasticsearch][:base_name]}-#{node[:elasticsearch][:version]}.#{node[:elasticsearch][:ext]}"
default[:elasticsearch][:s3_bucket] = 'dodge-dev-opsworks/software-deployments'