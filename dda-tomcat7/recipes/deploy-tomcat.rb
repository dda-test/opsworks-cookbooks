package 'install tomcat 7 package' do
  package_name 'tomcat7'
  action :install
end

include_recipe 'dda-tomcat7::tomcat-service'
include_recipe 'dda-tomcat7::configure-tomcat7'
include_recipe 'apache2'
include_recipe 'dda-tomcat7::apache-tomcat-bind'
include_recipe 'dda-tomcat7::configure-apache-proxy'
