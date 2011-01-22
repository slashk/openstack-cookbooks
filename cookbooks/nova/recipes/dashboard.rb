package "bzr"

directory "#{node[:nova][:dashboard][:deploy_dir]}" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

execute "bzr branch #{node[:nova][:dashboard][:django_nova_branch]} #{node[:nova][:dashboard][:django_nova_dir]}" do
    cwd node[:nova][:dashboard][:deploy_dir]
    not_if { File.directory?(node[:nova][:dashboard][:django_nova_dir]) }
end

execute "bzr branch #{node[:nova][:dashboard][:dashboard_branch]} #{node[:nova][:dashboard][:dashboard_dir]}" do
    cwd node[:nova][:dashboard][:deploy_dir]
end





