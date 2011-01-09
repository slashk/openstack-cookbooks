name "nova-support-servers"

run_list(
    "role[mysql-server]",
    "role[openldap-server]",
    "role[rabbitmq-server]"
)
