package "bzr"
package "apache2"
package "libapache2-mod-wsgi"

directory "#{node[:nova][:dashboard][:deploy_dir]}" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

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

execute "python setup.py install" do
    cwd node[:nova][:dashboard][:django_nova_dir]
end

execute "python tools/install_venv.py" do
    cwd node[:nova][:dashboard][:dashboard_dir]
end

template "#{node[:nova][:dashboard][:dashboard_dir]}/local/local_settings.py" do
    owner "root"
    group "root"
    source "dashboard.local_settings.erb"
    mode "0644"
end

template "#{node[:nova][:dashboard][:dashboard_dir]}/local/dashboard.wsgi" do
    owner "root"
    group "root"
    source "dashboard.wsgi.erb"
end

template "#{node[:nova][:dashboard][:apache_dir]}/sites-available/default" do
  owner "root"
  group "root"
  source "dashboard.apache.erb"
  mode "0644"
end

execute "/etc/init.d/apache2 restart"

