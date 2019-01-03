#cloud-config
users:
  - gecos: root
    lock-passwd: true
    name: root
    primary-group: root
    ssh-authorized-keys: ${authorized_keys}
write_files:
  - path: /etc/ssh/sshd_config
    content: |
        Port ${ssh_port}
        PasswordAuthentication no
        ChallengeResponseAuthentication no
        UsePAM yes
        X11Forwarding yes
        PrintMotd no
        AcceptEnv LANG LC_*
        Subsystem    sftp    /usr/lib/openssh/sftp-server
