define :glance_service do

  service_name="glance-#{params[:name]}"

  service service_name do
    start_command "su -c '#{service_name} --flagfile=/etc/glance/glance.conf --pidfile=/var/run/glance/#{service_name}.pid --daemonize' glance"
    stop_command "kill -s TERM $(cat /var/run/glance/#{service_name}.pid)"
    status_command "pgrep #{service_name}"
    supports :status => true, :restart => false
    action :start
    subscribes :restart, resources(:template => "/etc/glance/glance.conf")
  end

end
