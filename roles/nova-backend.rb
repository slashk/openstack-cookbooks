name "nova-backend"

run_list(
    "role[nova-volume]",
    "role[nova-compute]"
)
