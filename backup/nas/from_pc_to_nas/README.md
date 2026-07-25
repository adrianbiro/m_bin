# Install

```bash
ansible-playbook -i hosts.ini installBackup.ansible.yaml --ask-pass
# ansible-playbook -i hosts.ini installBackup.ansible.yaml --extra-vars "ansible_sudo_pass=yourPassword"
systemctl status bkp_rsync_nas.service 
systemctl status bkp_rsync_nas.timer
```

## Debbug

```bash
systemd-analyze verify <service_name>
systemd-run --user --wait ./<file.sh>
sudo systemctl edit --force --full  <service_name.timer>
sudo systemctl daemon-reload 
sudo systemctl enable --now <service_name.timer>
systemctl status gitsBackup
# log rotate
sudo logrotate --debug /etc/logrotate.d/bkp_rsync_nas.log
sudo less /var/lib/logrotate/status
```

* check `~/.ssh/config` and `~/.ssh/known_hosts`

## Links

<https://linux.die.net/man/8/logrotate>
