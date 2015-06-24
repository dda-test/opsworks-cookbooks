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