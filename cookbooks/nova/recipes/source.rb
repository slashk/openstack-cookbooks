#
# Cookbook Name:: nova
# Recipe:: source
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

services_base_dir = "/srv"
nova_base_dir = File.join(services_base_dir, "nova")
local_branch_name = "running"
local_branch_dir = File.join(nova_base_dir, local_branch_name)

execute "easy_install virtualenv"

package "bzr"

execute "bzr init-repo nova" do
  cwd services_base_dir
  not_if { File.directory?(nova_base_dir) }
end

execute "bzr branch #{node[:nova][:bzr_branch]} #{local_branch_name}" do
  cwd nova_base_dir
  not_if { File.directory?(local_branch_dir) }
end

execute "python tools/install_venv.py" do
  cwd local_branch_dir
  not_if { File.exists?(File.join(local_branch_dir, ".nova-venv/bin/activate")) }
end

# is there an easier way to do this? automation? Relative paths?

execute "echo #{local_branch_dir} >> #{File.join(local_branch_dir, "/.nova-venv/lib/python2.6/site-packages/nova.pth")}"
