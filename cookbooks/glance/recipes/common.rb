#
# Cookbook Name:: glance
# Recipe:: common
#
#

package "glance" do
  options "--force-yes"
  action :install
end

[node[:glance][:logdir], node[:glance][:working_directory], File::dirname(node[:glance][:config_file])].each do |glance_dir|

  directory glance_dir do
    owner "glance"
    group "root"
    mode "0755"
    action :create
  end

end

template node[:glance][:config_file] do
  source "glance.conf.erb"
  owner "glance"
  group "root"
  mode 0644
end
