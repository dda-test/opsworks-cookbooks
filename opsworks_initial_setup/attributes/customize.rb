normal[:opsworks_initial_setup][:bind_mounts][:mounts] = {
  '/srv/www' => "/mnt/ebs/srv/www",
  '/var/www' => "/mnt/ebs/var/www",
  '/var/log/httpd' => "/mnt/ebs/var/log/httpd",
  '/var/log/tomcat7' => "/mnt/ebs/var/log/tomcat7",
}
