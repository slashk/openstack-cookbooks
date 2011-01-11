#
# Cookbook Name:: nova
# Recipe:: default
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

file "/etc/apt/sources.list.d/anso.list" do
  content <<-EOH
deb http://packages.ansolabs.com ./
deb-src http://packages.ansolabs.com ./
  EOH
  mode "0644"
end

execute "apt-get update" do
  subscribes :run, resources(:file => "/etc/apt/sources.list.d/anso.list"), :immediately
  action :nothing
end

%w{euca2ools unzip nova-compute nova-api nova-objectstore nova-scheduler nova-network nova-volume}.each do |pkg|
  package pkg do
    options "--force-yes"
  end
end

execute "nova-manage user admin #{node[:nova][:user]}" do
  not_if "nova-manage user list | grep #{node[:nova][:user]}"
end

execute "nova-manage project create #{node[:nova][:project]} #{node[:nova][:user]}" do
  not_if "nova-manage project list | grep #{node[:nova][:project]}"
end

