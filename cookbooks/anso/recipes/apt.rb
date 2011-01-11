#
# Cookbook Name:: apt
# Recipe:: anso
#
# Copyright 2011, Anso Labs
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

include_recipe 'apt'

if node[:anso][:cacher_url]
  file "/etc/apt/sources.list.d/cacher.list" do
    content <<-EOH
  deb #{node[:anso][:cacher_url]} maverick main
  deb-src #{node[:anso][:cacher_url]} maverick main
    EOH
    mode "0644"
    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end

file "/etc/apt/sources.list.d/nova.list" do
  content <<-EOH
deb #{node[:anso][:packages_url]} maverick main
deb-src #{node[:anso][:packages_url]} maverick main
  EOH
  mode "0644"
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

node[:anso][:keys].each do |key|
  execute "apt-key adv --keyserver #{node[:anso][:keyserver]} --recv #{key}" do
    subscribes :run, resources(:file => "/etc/apt/sources.list.d/nova.list"), :immediately
    action :nothing
  end
end
