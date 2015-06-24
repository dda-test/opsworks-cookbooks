old_jvm6_pkg_to_remove = 'java-1.6.0-openjdk'
old_jvm7_pkg_to_remove = 'java-1.7.0-openjdk'
jvm8_pkg_to_install = 'java-1.8.0-openjdk'

package "remove old JVM package #{old_jvm6_pkg_to_remove}" do
  package_name old_jvm6_pkg_to_remove
  action :nothing
end

package "remove old JVM package #{old_jvm7_pkg_to_remove}" do
  package_name old_jvm7_pkg_to_remove
  action :nothing
end

# install OpenJDK in either case to satisfy package dependencies
package 'install new JVM package #{jvm8_pkg_to_install}' do
  package_name jvm8_pkg_to_install
  action :install
  notifies :remove, "package[remove old JVM package #{old_jvm6_pkg_to_remove}]", :immediately
  notifies :remove, "package[remove old JVM package #{old_jvm7_pkg_to_remove}]", :immediately
end
