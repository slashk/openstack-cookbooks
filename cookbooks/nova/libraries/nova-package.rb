#
# Cookbook Name:: nova
# Recipe:: nova-package helper
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

module NovaPackage
  def nova_package(name)
    nova_name = "nova-#{name}"
    case node[:nova][:install_type]
    when "source"
      include_recipe "nova::source"
      runit_service nova_name
    when "binary"
      include_recipe "apt"
      include_recipe "nova::common"
      package nova_name do
        options "--force-yes"
        action :install
      end
      service nova_name do
        if (platform?("ubuntu") && node.platform_version.to_f >= 10.04)
          restart_command "restart #{nova_name}"
          stop_command "stop #{nova_name}"
          start_command "start #{nova_name}"
          status_command "status #{nova_name}"
        end
        supports :status => true, :restart => true, :reload => true
        action :nothing
        subscribes :restart, resources(:file => "/etc/default/nova-common")
      end
    end
  end
end
