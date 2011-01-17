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

if node[:nova][:mysql]
  mysql = search(:node, 'recipes:nova\:\:mysql')
  log "The result is #{mysql.to_s}"
  raise 'die'
  if mysql
    db = mysql[0]
    sql_connection = "mysql://#{db[:nova][:db][:user]}:#{db[:nova][:db][:password]}@#{db[:nova][:my_ip]}/#{db[:nova][:db][:database]}"
  end
end

log "sql connection set to '#{sql_connection}'"

template "/etc/nova/nova.conf" do
  source "nova.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables ( :sql_connection => sql_connection )
end
