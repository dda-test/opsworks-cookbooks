default[:logstash] = {}
default[:logstash][:install_dir] = '/mnt/ebs/logstash'
default[:logstash][:base_name] = 'logstash'
default[:logstash][:version] = '1.5.0'
default[:logstash][:ext] = 'tar.gz'
default[:logstash][:archive_name] = "#{node[:logstash][:base_name]}-#{node[:logstash][:version]}.#{node[:logstash][:ext]}"
default[:logstash][:s3_bucket] = 'dodge-dev-opsworks/software-deployments'
