service 'elasticsearch' do
  service_name 'elasticsearch'
  init_command "/etc/init.d/elasticsearch"

  supports [:restart, :reload, :status]

  action :nothing
end