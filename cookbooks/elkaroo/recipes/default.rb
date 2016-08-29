#
# Cookbook Name:: elkaroo
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'elkaroo::firewall'

include_recipe 'java'

include_recipe 'elkaroo::elasticsearch'

include_recipe 'elkaroo::kibana'

include_recipe 'elkaroo::logstash_server'
# include_recipe 'elkaroo::logstash_agent'
