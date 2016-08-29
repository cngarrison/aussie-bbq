
name = 'server'

logstash_instance name do
  action :create
end

logstash_service name do
  action [:enable]
end

logstash_config name do
  action [:create]
  notifies :restart, "logstash_service[#{name}]"
end
# ^ see `.kitchen.yml` for example attributes to configure templates.

#  logstash_plugins 'contrib' do
#   instance name
#   name 'logstash-output-influxdb'
#   action [:create]
#  end

logstash_pattern name do
  action [:create]
end

logstash_curator 'server' do
  action [:create]
end
