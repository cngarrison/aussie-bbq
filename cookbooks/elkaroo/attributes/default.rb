
# def generate_salt(size)
#   ITOA64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#   (1..size).collect { ITOA64[rand(ITOA64.size)].chr }.join("")
# end
def crypt_password(passwd)
#   passwd.crypt(generate_salt(2))
## If we use a random salt then we get a different value for `auth_password` on each chef-client run
  passwd.crypt('Za')
end

default['firewall']['allow_ssh'] = true
default['elkaroo']['open_ports'] = [80, 443]


## CHANGE the `admin_password`
default['elkaroo']['nginx']['admin_password'] = 'abcd'

default['elkaroo']['nginx']['auth_username'] = 'admin'
default['elkaroo']['nginx']['auth_password'] = crypt_password(default['elkaroo']['nginx']['admin_password'])


default['java']['jdk_version'] = '8'



default['kibana']['install_type'] = 'file' # git | file

default['kibana']['version'] = '4.5.4-linux-x64' # must match version number of kibana being installed

default['kibana']['file']['checksum'] = 'f4f11ce06679f734d01446d0e4016256c4d9f57be6d07a790dbf97bed0998b44'

default['kibana']['file']['config_template_cookbook'] = 'elkaroo' # cookbook containing config template

default['kibana']['nginx']['enable_default_site'] = false

default['kibana']['nginx']['template'] = 'kibana-nginx-file.conf.erb'
default['kibana']['nginx']['template_cookbook'] = 'elkaroo'



default['logstash']['server']['input_log_path'] = "/home/ubuntu/ngx-debug*.log"

default['logstash']['instance_default']['elasticsearch_ip'] = 'localhost'
default['logstash']['instance_default']['elasticsearch_port'] = '9200'
default['logstash']['instance_default']['elasticsearch_embedded'] = false

# default['logstash']['instance_default']['pattern_templates_cookbook']  = 'elkaroo'
# default['logstash']['instance_default']['pattern_templates']           = {'nginx' => 'patterns/nginx'}
# default['logstash']['instance_default']['pattern_templates_variables'] = {}

default['logstash']['instance_default']['config_templates']           = {'nginx' => 'logstash-nginx.conf.erb'}
default['logstash']['instance_default']['config_templates_cookbook']  = 'elkaroo'
default['logstash']['instance_default']['config_templates_variables'] = \
  {'es_server_ip' => '127.0.0.1:9200', 'es_cluster' => 'elasticsearch', 'graphite_server_ip' => ''}


## needed for server.conf.erb template
default['logstash']['instance_default']['version']        = '1.5.4'

## Would rather use more current logstash, but `sv` script needed too many modifications for quick project
# default['logstash']['instance_default']['version']        = '2.3.4'
# # default['logstash']['instance_default']['source_url']     = 'https://download.elastic.co/logstash/logstash/logstash-2.3.4.tar.gz'
# # default['logstash']['instance_default']['checksum']       = '7f62a03ddc3972e33c343e982ada1796b18284f43ed9c0089a2efee78b239583'
# default['logstash']['instance_default']['source_url']     = 'https://download.elastic.co/logstash/logstash/logstash-all-plugins-2.3.4.tar.gz'
# default['logstash']['instance_default']['checksum']       = 'b9d63bfa5c17ccd10601a387803e773edbb70ef45fc0e2dfb1166b514c414aa2'
