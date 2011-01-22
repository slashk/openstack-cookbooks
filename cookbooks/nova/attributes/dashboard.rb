default[:nova][:dashboard][:deploy_dir] = "/deploy"
default[:nova][:dashboard][:dashboard_dir] = File.join(node[:nova][:dashboard][:deploy_dir], "openstack-dashboard")
default[:nova][:dashboard][:dashboard_branch] = "lp:openstack-dashboard"
default[:nova][:dashboard][:django_nova_dir] = File.join(node[:nova][:dashboard][:deploy_dir], "django-nova")
default[:nova][:dashboard][:django_nova_branch] = "lp:django-nova"
