name "vanilla"
default_source :supermarket

run_list "ubuntu", "minecraft"

cookbook "minecraft", path: "../"

default['minecraft']['accept_eula'] = true
