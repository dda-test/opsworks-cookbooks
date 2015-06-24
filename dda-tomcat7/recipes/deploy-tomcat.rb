package 'install tomcat 7 package' do
  package_name 'tomcat7'
  action :install
end

include_recipe 'tomcat-service'
include_recipe 'configure-tomcat7'
include_recipe 'apache2'
include_recipe 'apache-tomcat-bind'
