#
# Cookbook Name:: nova
# Attributes:: default
#
# Copyright 2008-2009, Opscode, Inc.
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

default[:nova][:install_type] = "binary"
default[:nova][:compute_connection_type] = "qemu"
default[:nova][:user] = "admin"
default[:nova][:project] = "admin"
default[:nova][:creds][:user] = "nova"
default[:nova][:creds][:group] = "nogroup"
default[:nova][:creds][:dir] = "/var/lib/nova"
default[:nova][:my_ip] = ipaddress
default[:nova][:mysql] = true
default[:nova][:images] = []
