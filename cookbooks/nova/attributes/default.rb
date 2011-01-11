default[:nova][:install_type] = "binary"
default[:nova][:compute_connection_type] = "qemu"
default[:nova][:user] = "admin"
default[:nova][:project] = "admin"
default[:nova][:creds][:user] = "nova"
default[:nova][:creds][:group] = "nogroup"
default[:nova][:creds][:dir] = "/var/lib/nova"
default[:nova][:images] = []

