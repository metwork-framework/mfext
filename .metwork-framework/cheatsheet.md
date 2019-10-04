# MetWork/mfext cheatsheet

## `root` service commands

As `root` unix user:

| Command | Description |
| --- | --- |
| `service metwork start` | start all installed metwork services |
| `service metwork stop` | stop all installed metwork services |
| `service metwork status` | check all installed metwork services |


> Note: if you don't have `service` command on your Linux distribution, you can use `/etc/rc.d/init.d/metwork` instead of `service metwork`. For example: `/etc/rc.d/init.d/metwork start` instead of `service metwork start`. If your Linux distribution uses `systemd`component, you can also start metwork services with classic `systemctl` commands.





## "load environment" commands

As a "not metwork" unix user:

| Command | Description |
| --- | --- |
| `source /opt/metwork-mfext/share/interactive_profile` | FIXME |
| `source /opt/metwork-mfext/share/profile` | FIXME |
| `/opt/metwork-mfext/bin/mfext_wrapper {YOUR_COMMAND}`| FIXME |
| `outside {YOUR_COMMAND}`| FIXME |

> Note: if you don't have `/opt/metwork-mfext` symbolic link, use `/opt/metwork-mfext-{BRANCH}` instead.



## module commands

As `mfext` user:

| Command | Description |
| --- | --- |

| `layers`| FIXME |
| `components` | FIXME | 






FIXME:

- layer_load
- layer_unload
