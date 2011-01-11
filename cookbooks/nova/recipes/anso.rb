#
# Cookbook Name:: nova
# Recipe:: anso
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

file "/etc/apt/sources.list.d/anso.list" do
  content <<-EOH
deb http://packages.ansolabs.com maverick main
deb-src http://packages.ansolabs.com maverick main
  EOH
  mode "0644"
end

execute 'apt-key adv --keyserver pgpkeys.mit.edu --recv 40976EAF437D05B5' do
  subscribes :run, resources(:file => "/etc/apt/sources.list.d/anso.list"), :immediately
  action :nothing
end

execute 'apt-key adv --keyserver pgpkeys.mit.edu --recv 6A4F7797460DF9BE' do
  subscribes :run, resources(:file => "/etc/apt/sources.list.d/anso.list"), :immediately
  action :nothing
end

execute "apt-get update" do
  subscribes :run, resources(:file => "/etc/apt/sources.list.d/anso.list"), :immediately
  action :nothing
end
