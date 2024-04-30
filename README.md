# Automating Common IT Infra Tasks
Repo that contains scripts to automate various infrastructure activities like developer workstation setup and configuration.

## Setting up User Workstations
User workstations can be set up with the required development tools by running the following command in a terminal. Needs to be run by a user with sudo access. Script is tested to work on Ubuntu 18.04, 16.04 although it might work with newer versions too.

### If you got sudo access, run this command

```bash
sudo mkdir -p /tmp/ansible-ttpl-it-automation && sudo wget -q "https://raw.githubusercontent.com/techjoomla/infra-automation/master/ttpl_install.sh" -O /tmp/ansible-ttpl-it-automation/ttpl_install.sh && sudo chmod +x /tmp/ansible-ttpl-it-automation/ttpl_install.sh && sudo /tmp/ansible-ttpl-it-automation/ttpl_install.sh
```

The script will set up all the tools defined in the `environment-setup.yml` file and also set up vhosts, each for each php version

## Accessing sites

-   Accessing sites locally
    -   To access the PHP5 localhost, navigate to https://machineusername-php5.local/ Eg: https://ttpl21-php5.local/
    -   To access the PHP7 localhost, navigate to http://machineusername-php7.local/ Eg: http://ttpl21-php7.local/
    -   To access the PHP7.1 localhost, navigate to http://machineusername-php71.local/ Eg: http://ttpl21-php71.local/
    -   To access the PHP7.2 localhost, navigate to http://machineusername-php72.local/ Eg: http://ttpl21-php72.local/
    -   To access the PHP7.3 localhost, navigate to http://machineusername-php73.local/ Eg: http://ttpl21-php73.local/
    -   To access the PHP7.4 localhost, navigate to http://machineusername-php74.local/ Eg: http://ttpl21-php74.local/
    -   To access the PHP8 localhost, navigate to http://machineusername-php8.local/ Eg: http://ttpl21-php8.local/
    -   To access the PHP8.1 localhost, navigate to http://machineusername-php81.local/ Eg: http://ttpl21-php81.local/
    -   To access the PHP8.2 localhost, navigate to http://machineusername-php82.local/ Eg: http://ttpl21-php82.local/
-   The files for these are present at /var/www/{machineusername}-{php-version}.local/public
-   Accessing database
    -   Adminer is installed for all vhosts at /var/www/ttpl21-{php-version}.local/public/adminer
    -   Can be accessed as http://{machineusername}-{php-version}.local/adminer
    -   If PHPMyAdmin / Adminer is not installed, so you can download Adminer (http://adminer.org/) and place the file anywhere in your local

## Installation Troubleshooting

### nginx can not be started

-   Run command `sudo nginx -t`
    -   If command shows error related to SSL certifcates not found for php5 sites, run below command (replace {machineusername} with your username)
    -   `sudo openssl req -new -nodes -x509 -subj "/C=IN/ST=Maharashtra/L=Pune/O=Chacha Chaudhary and Co./CN={machineusername}-php5.local" -days 3650 -keyout /etc/nginx/ssl/{machineusername}-php5.local.key -out /etc/nginx/ssl/{machineusername}-php5.local.crt`
    -   Then run command `sudo service nginx restart`
    -   Then retry installation
