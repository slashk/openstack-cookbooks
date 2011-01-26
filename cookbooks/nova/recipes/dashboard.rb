package "python-pip"
package "python-virtualenv"
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

file "/usr/lib/python2.6/dist-packages/dashboard.pth" do
  content node[:nova][:dashboard][:dashboard_dir]
end

execute "python setup.py install" do
    cwd node[:nova][:dashboard][:django_nova_dir]
end

execute "pip install -r #{node[:nova][:dashboard][:dashboard_dir]}/tools/pip-requires" do
    cwd node[:nova][:dashboard][:django_nova_dir]
end

template "#{node[:nova][:dashboard][:dashboard_dir]}/local/local_settings.py" do
    owner "root"
    group "root"
    source "dashboard.local_settings.erb"
    mode "0644"
end

template "#{node[:nova][:dashboard][:apache_dir]}/sites-available/default" do
  owner "root"
  group "root"
  source "dashboard.apache.erb"
  mode "0644"
end

execute "python manage.py syncdb --noinput" do
    cwd "#{node[:nova][:dashboard][:dashboard_dir]}/dashboard"
end

execute "python manage.py createsuperuser --username=#{node[:nova][:dashboard][:admin_username]} --email=#{node[:nova][:dashboard][:admin_email]} --noinput" do
    cwd "#{node[:nova][:dashboard][:dashboard_dir]}/dashboard"
end

execute "/etc/init.d/apache2 restart"

