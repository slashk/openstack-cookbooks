#
# Cookbook Name:: nova
# Recipe:: common
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"

package "nova-common" do
  options "--force-yes -o Dpkg::Options::=\"--force-confdef\""
  action :install
end

directory "/etc/nova" do
    owner "root"
    group "root"
    mode 0755
    action :create
end

sql_connection = nil

env_filter = ''
if node[:app_environment]
  env_filter = " AND app_environment:#{node[:app_environment]}"

if node[:nova][:mysql]
  package "python-mysqldb"
  mysqls = search(:node, "recipes:nova\:\:mysql#{env_filter}")
  if mysqls
    mysql = mysqls[0]
    sql_connection = "mysql://#{mysql[:nova][:db][:user]}:#{mysql[:nova][:db][:password]}@#{mysql[:nova][:my_ip]}/#{mysql[:nova][:db][:database]}"
  end
end

rabbit_settings = nil
rabbits = search(:node, "recipes:nova\:\:rabbit#{env_filter}")
if rabbits
  rabbit = rabbits[0]
  rabbit_settings = {
    :address => rabbit[:rabbitmq][:address],
    :port => rabbit[:rabbitmq][:port],
    :user => rabbit[:nova][:rabbit][:user],
    :password => rabbit[:nova][:rabbit][:password],
    :vhost => rabbit[:nova][:rabbit][:vhost]
  }
end

template "/etc/nova/nova.conf" do
  source "nova.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables (
    :sql_connection => sql_connection,
    :rabbit_settings => rabbit_settings
  )
end
