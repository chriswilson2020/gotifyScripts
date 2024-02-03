# gotifyScripts
Repository for gotify notification scripts

# Alert scripts
The following scripts send notifications from a server for various actions to notify of potential unauthorised actions
Place the script in the appropriate location and make them executable `chmod +x [filename]`

| Command       | Location          | Purpose  |
| ------------- |:-----------------:| :--------|
|gotify_login_alert.sh| /usr/local/bin| Script to notify who logged in where and from what IP address |
|gotify_su_alert.sh| /usr/local/bin | Script to notify when a user changes to another user i.e. obtains root |
|gotify_sudo_alert.sh| /usr/local/bin | Script to notify when a command is executed with elevated priviladge|

**Note**: Don't forget to edit the scripts with your application token and link to your gotify instance

## PAM script changes 
In order for the scripts to function you should adust your pam configuration files in `/etc/pam.d/[script name]` to execute the alert script files

**Add the following to the end of the session portions of the respective files:

| Script       | pam.d config file        | Entry to add  |
| ------------- |:-----------------:| :--------|
| gotify_login_alert.sh | login | `session    optional     pam_exec.so /usr/local/bin/gotify_login_alert.sh`|
| gotify_login_alert.sh | sshd | `session    optional     pam_exec.so /usr/local/bin/gotify_login_alert.sh`|
| gotify_su_alert.sh | su | `session    optional     pam_exec.so /usr/local/bin/gotify_su_alert.sh`|
| gotify_sudo_alert.sh | sudo | `session    optional     pam_exec.so /usr/local/bin/gotify_sudo_alert.sh`|
