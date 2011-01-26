default[:nova][:dashboard][:admin_email] = "admin@example.com"
default[:nova][:dashboard][:admin_username] = "admin"
default[:nova][:dashboard][:deploy_dir] = "/srv"
default[:nova][:dashboard][:dashboard_dir] = File.join(node[:nova][:dashboard][:deploy_dir], "openstack-dashboard")
default[:nova][:dashboard][:dashboard_branch] = "lp:openstack-dashboard"
default[:nova][:dashboard][:django_nova_dir] = File.join(node[:nova][:dashboard][:deploy_dir], "django-nova")
default[:nova][:dashboard][:django_nova_branch] = "lp:django-nova"
default[:nova][:dashboard][:apache_dir] = "/etc/apache2"

