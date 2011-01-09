name "nova-head"

run_list(
    "role[nova-api]",
    "role[nova-objectstore]"
)
