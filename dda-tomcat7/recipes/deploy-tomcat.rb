package 'install tomcat 7 package' do
  package_name 'tomcat7'
  action :install
end

# if CATALINA_OPTS not there add it to /etc/tomcat7/tomcat7.conf
service "tomcat7" do
action :stop
end

execute "add catalina opts to tomcat7.conf" do
command 'grep -s "CATALINA_OPTS" /etc/tomcat7/tomcat7.conf || sed -i -e "\$aCATALINA_OPTS=\"\${CATALINA_OPTS} -Xms4096m -Xmx4096m -XX:+UseG1GC -XX:MaxGCPauseMillis=500\"" /etc/tomcat7/tomcat7.conf'
end

service "tomcat7" do
action :start
end

include_recipe 'apache2'

#next 2 executes taken from:  include_recipe 'opsworks_java::apache_tomcat_bind'
execute 'enable mod_proxy for apache-tomcat binding' do
  command '/usr/sbin/a2enmod proxy'
  not_if do
    ::File.symlink?(::File.join(node['apache']['dir'], 'mods-enabled', 'proxy.load')) || 'proxy_http' !~ /\Aproxy/
  end
end

execute 'enable module for apache-tomcat binding' do
  command "/usr/sbin/a2enmod proxy_http"
  not_if {::File.symlink?(::File.join(node['apache']['dir'], 'mods-enabled', "proxy_http.load"))}
end