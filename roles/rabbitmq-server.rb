name "rabbitmq-server"

run_list(
    "recipe[apt]",
    "recipe[rabbitmq]"
)
