log "Installing java 1.8 (openjdk)"
package "java-1.8.0-openjdk"

log "Removing java-1.7.0-openjdk"
package "java-1.7.0-openjdk" do
	action :remove
end

#log "Installing Tomcat and Apache httpd"
#include_recipe 'opsworks_java::tomcat_setup'

# if CATALINA_OPTS not there add it to /etc/tomcat7/tomcat7.conf
if FileTest.file?("/etc/tomcat7/tomcat7.conf")

  service "tomcat7" do
    action :stop
  end

  execute "add catalina opts to tomcat7.conf" do
    command 'grep -s "CATALINA_OPTS" /etc/tomcat7/tomcat7.conf || sed -i -e "\$aCATALINA_OPTS=\"\${CATALINA_OPTS} -Xms4096m -Xmx4096m -XX:+UseG1GC -XX:MaxGCPauseMillis=500\"" /etc/tomcat7/tomcat7.conf'
  end

  service "tomcat7" do
    action :start
  end

end