#!/bin/bash

read -p "Enter non-admin username (eg: ttpl1) : "  non_admin_username

php83_name="${non_admin_username}-php83.local"
php82_name="${non_admin_username}-php82.local"
php81_name="${non_admin_username}-php81.local"
php8_name="${non_admin_username}-php8.local"
php74_name="${non_admin_username}-php74.local"
php73_name="${non_admin_username}-php73.local"
php72_name="${non_admin_username}-php72.local"
php71_name="${non_admin_username}-php71.local"
php7_name="${non_admin_username}-php7.local"
php5_name="${non_admin_username}-php5.local"
non_admin_home_dir="/home/${non_admin_username}"

if [ ! -d "$non_admin_home_dir" ]; then
	echo "Invalid username"
	exit 1
fi

if [[ -r /etc/lsb-release ]]; then
	. /etc/lsb-release
	if [[ ( $ID == "ubuntu" ) || ( $DISTRIB_ID == "Ubuntu" ) ]]; then
		echo "Running Ubuntu $UBUNTU_VERSION_NAME $DISTRIB_CODENAME"

		sudo apt-add-repository -y ppa:ansible/ansible
		sudo apt-get update
		sudo apt-get -y install ansible

		sudo wget -q https://github.com/techjoomla/infra-automation/archive/master.zip -O /tmp/master.zip
		sudo unzip -oq /tmp/master.zip -d /tmp

		# Env. setup
		sudo ansible-playbook -i "hosts," -c local /tmp/infra-automation-master/environment-setup.yml --skip-tags "createuser,ansible,aptupdate,python" --extra-vars="server_runs_as=$non_admin_username" #-vvv

		# Create PHP env.s
		# Uncomment #vvv below to debug ansible
		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php5_name site_id=php5 php_install_version=5.6 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username vhost_ssl=1 site_ssl=1 ssl_selfsigned=1" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php7_name site_id=php7 php_install_version=7.0 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php71_name site_id=php71 php_install_version=7.1 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php72_name site_id=php72 php_install_version=7.2 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php73_name site_id=php73 php_install_version=7.3 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php74_name site_id=php74 php_install_version=7.4 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php8_name site_id=php8 php_install_version=8.0 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php81_name site_id=php81 php_install_version=8.1 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php82_name site_id=php82 php_install_version=8.2 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		sudo ansible-playbook -i "localhost," -c local /tmp/infra-automation-master/create-site.yml --extra-vars="which_host=localhost site_domain=$php83_name site_id=php83 php_install_version=8.3 server_runs_as=$non_admin_username server_runs_as_group=$non_admin_username" #-vvv

		#echo "Updating Launcher Icons"
		#gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://firefox.desktop', 'application://google-chrome.desktop', 'application://geany.desktop', 'application://gnome-terminal.desktop',  'application://skype.desktop', 'application://filezilla.desktop', 'application://virtualbox.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
	else
		echo "Not running an Ubuntu distribution. ID=$ID, VERSION=$VERSION"
	fi
else
	echo "Not running a distribution with /etc/lsb-release available"
fi
