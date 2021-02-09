# Automating Common IT Infra Tasks

Repo that contains scripts to automate various infrastructure activities like developer workstation setup and configuration.

  

## Setting up User Workstations

User workstations can be set up with the required development tools by running the following command in a terminal. Needs to be run by a user with sudo access. Script is tested to work on Ubuntu 16.04 & 14.04 although it might work with newer versions too.

  

```bash

sudo mkdir -p /tmp/ansible-ttpl-it-automation && sudo wget -q "https://raw.githubusercontent.com/techjoomla/infra-automation/master/ttpl_install.sh" -O /tmp/ansible-ttpl-it-automation/ttpl_install.sh && sudo chmod +x /tmp/ansible-ttpl-it-automation/ttpl_install.sh && sudo /tmp/ansible-ttpl-it-automation/ttpl_install.sh

```

The script will set up all the tools defined in the `environment-setup.yml` file and also set up 2 vhosts, one each for PHP5 & PHP7

  

- To access the PHP5 localhost, navigate to http://machineusername-php5.local/ Eg: http://ttpl21-php5.local/

- To access the PHP7 localhost, navigate to http://machineusername-php7.local/ Eg: http://ttpl21-php7.local/

- The files for this are present in /var/www/ttpl21-php5.local/public or in /var/www/ttpl21-php7.local/public

- PHP My Admin is not installed, so you can download Adminer (http://adminer.org/) and place the file anywhere in your local

  

## Joomla site CI CD
1. Create folder `secret` alongside joomla.yml to store your server encrypted details (using ansible vault)

	```javascript
	joomla_user: "username" # Username to connect your host through ssh
	joomla_password: "password" # Password to connect your host through ssh
	joomla_db: "MYDB" # Database
	joomla_host: "localhost" # Database host
	joomla_dbprefix: "z467w_" # Table prefix
	joomla_smtpuser: "" # SMTP Username
	joomla_smtppass: "" # SMTP Password
	joomla_smtphost: "localhost" # SMTP Host
	```

2. Create folder `inventory` alongside joomla.yml to store your server details and Joomla configurations

	E.g:
	file: inventory/myserver
	```javascript

	[mysitegroup]
	YOUR_SERVER_IP  ansible_host=YOUR_SERVER_HOST  ansible_user={{joomla_user}} ansible_ssh_private_key_file=SSH_KEY_PATH

	[mysitegroup:vars]
	doc_root=/home/{{joomla_user}}/public_html # PATH to deploy Joomla files
	site_id=myserver # Name of secret file
	deploy_env_domain=example.com # Site domain e.g  example.com
	server_runs_as=www-data # Server user
	server_runs_as_group=www-data # Group of files
	joomla_sitename="core Site" # Overridden site name
	joomla_log_path="/home/USER_NAME/public_html/logs"  # Log path
	joomla_tmp_path="/home/USER_NAME/public_html/tmp"   # Tmp folder path
	```
  
### Run playbook
```bash
ansible-playbook -i inventory/myserver joomla.yml --vault-password-file=PATH_OF_VAULT_PASSWORD_FILE
```