# elkaroo - kangaroos cook as good as elk

## Another elk recipe, specifically for filtering custom nginx logformat 

### Steps deploy the elkaroo cookbok using `kitchen`:

0. Clone the `aussie-bbq` chef-repo
   - `git clone git@github.com:cngarrison/aussie-bbq.git`
1. Setup AWS credentials (if not already done) using 
   - `aws configure`
2. Create 'local kitchen config file' and add the custom attribites (see below), substitute values for your ssh key
   - `vi aussie-bbq/cookbooks/elkaroo/.kitchen.local.yml`
3. Edit default attributes file and change `admin_password` (`default['elkaroo']['nginx']['admin_password']`)
   - `vi aussie-bbq/cookbooks/elkaroo/attributes/default.rb`
4. Change to the 'elkaroo' cookbook dir
   - `cd aussie-bbq/cookbooks/elkaroo`
4. Use `kitchen` to create AWS instance, bootstrap chef-client, upload cookbooks, and run chef-client
   - `kitchen converge`
5. Get 'Public DNS Name' for new EC2 instance
   - `aws ec2 describe-instances | grep PublicDnsName`
6. Copy nginx log file to EC2 instance
   - `scp -i ~/.ssh/<user_key_id>.pem path/to/ngx-debug.log ubuntu@ec2.public.dns.name:`
7. Connect to Kibana using _http://ec2.public.dns.name_ and login with username `admin` and password you set in `attributes.default.rb`
8. Add `logstash-*` index, and click `Discover` to begin reviewing log data


This recipe has only been tested with `kitchen` but should work equally as well deployed with `knife` to a chef server. 

Any logstash `input` plugin can be used. Simply edit the `templates/default/logstash-nginx.conf.erb` template and add the 
preferred `input` config, eg. using a logstash agent.

SSL cert can be added to nginx by editing the `templates/default/kibana-nginx-file.conf.erb` file.

After editing any of the templates or attributes, run `kitchen converge` again to push changes to server instance and run chef-client. 

Custom visualations can be added to Kibana using template config files. Specifics have been left as an exercise for later.

#### Contents of `.kitchen.local.yml` file, adjust as desired

	---
	driver:
	  aws_ssh_key_id: <user_key_id>
	  region: ap-southeast-2
	  availability_zone: c
	  security_group_ids: sg-ce145eaa
	  subnet_id: subnet-212e3967
 
	transport:
	  ssh_key: ~/.ssh/<user_key_id>.pem



### Requirements for elkaroo cookbook

#### Platform:

- ubuntu-14.04

#### Cookbooks:

- 'firewall', '~> 2.5.2'
- 'java', '~> 1.42.0'
- 'elasticsearch', '~> 2.3.2'
- 'kibana_lwrp', '~> 3.0.2'
- 'logstash', '~> 0.12.0'
- 'nginx', '~> 2.7.6'


### Attributes

- `node['elkaroo']['nginx']['admin_password']` - Defaults to `abcd`.

### Recipes

- elkaroo::default

### License and Maintainer

Maintainer:: (<charlie@garrison.com.au>)

License:: All rights reserved
