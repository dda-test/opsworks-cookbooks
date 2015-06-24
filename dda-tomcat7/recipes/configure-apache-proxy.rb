service "httpd" do
  action :stop
end

execute "add ProxyPass opts to httpd.conf" do
  command 'grep -s "ProxyPass / " /etc/httpd/conf/httpd.conf || sed -i -e "\$aProxyPass \/ http:\/\/localhost:8080\/\nProxyPassreverse \/ http:\/\/localhost:8080\/" /etc/httpd/conf/httpd.conf'
end

service "httpd" do
  action :start
end
