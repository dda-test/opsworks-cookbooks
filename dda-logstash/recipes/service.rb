aservice 'logstash' do
  service_name 'logstash'
  init_command "/etc/init.d/logstash"

  supports [:restart, :reload, :status]

  action :nothing
end