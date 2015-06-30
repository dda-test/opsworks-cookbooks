service 'elasticsearch' do
  service_name 'elasticsearch'

  supports [:restart, :reload, :status]

  action :nothing
end