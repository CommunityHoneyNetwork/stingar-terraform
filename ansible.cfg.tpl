[defaults]
forks               = 20
host_key_checking   = False
remote_user         = root
retry_files_enabled = False
nocows              = True
remote_port         = ${real_ssh_port}

[ssh_connection]
retries=5
