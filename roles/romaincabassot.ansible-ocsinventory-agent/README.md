romaincabassot.ansible-ocsinventory-agent
=========

Version : 1.0.2

Installs OCS inventory agent from a package repository and optionally setup the cron to launch the inventory.



Requirements
------------

A repository from which pull the Ocsinventory agent package (for example [remi repository](http://rpms.famillecollet.com/)).

Role Variables
--------------

    # Ocsinventory launch options
    # ---------------------------
    # The path to the ocsinventory binary file is defined in the OS vars but can be overriden
    ocsinventory_binary: "/usr/sbin/ocsinventory-agent"
    # The options to add when invoking the ocs inventory agent binary
    ocsinventory_launch_options: "--local=/var/lib/ocsinventory-agent"
    # If it launches the host inventory after an installation of the agent
    ocsinventory_launch_after_install: true
    
    # Cronjob options
    # ---------------
    # True to create a cronjob for host inventory
    ocsinventory_setup_cronjob: true
    # Name of the cronjob task
    ocsinventory_cronjob_name: "ocsinventory-agent"
    # User running the job
    ocsinventory_cronjob_user: "root"
    # When to execute the job
    ocsinventory_cronjob_month: "*"
    ocsinventory_cronjob_weekday: "*"
    ocsinventory_cronjob_day: "*"
    ocsinventory_cronjob_hour: "6"
    ocsinventory_cronjob_minute: "0"
    
    # Installation package configuration
    # ----------------------------------
    # Name of the package to install
    ocsinventory_package_name: "ocsinventory-agent"
    # Name of the yum package's repository
    ocsinventory_yum_repository: "remi"
    # Apt ocsinventory agent target-release (-t, --target-release, --default-release )
    ocsinventory_apt_target_release: ""


Dependencies
------------

None.  

Example Playbook
----------------

Install the Ocsinventory agent then launch the inventory of the machine and send it to http://myocsserver.domain.com/ocsinventory.
Setup a root cronjob named "ocsinventory-agent" scheduled at 6AM everyday that launches the inventory of the machine and send it to http://myocsserver.domain.com/ocsinventory.

    - hosts: servers
      roles:
         - { 
             role: ocsinventory-agent, 
             ocsinventory_launch_options: "--server=http://myocsserver.domain.com/ocsinventory",
             ocsinventory_launch_after_install: true
             ocsinventory_setup_cronjob: true
             ocsinventory_cronjob_name: "ocsinventory-agent"
             ocsinventory_cronjob_user: "root"
             ocsinventory_cronjob_month: "*"
             ocsinventory_cronjob_weekday: "*"
             ocsinventory_cronjob_day: "*"
             ocsinventory_cronjob_hour: "6"
             ocsinventory_cronjob_minute: "0"
           }

License
-------

BSD

Author Information
------------------

Romain CABASSOT
