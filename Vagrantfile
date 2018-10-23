# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "debian/contrib-stretch64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # REST API ports
  config.vm.network :forwarded_port, guest: 10666, host: 10666 # HTTP
  config.vm.network :forwarded_port, guest: 10667, host: 10667 # HTTPS

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  # Customize the amount of memory on the VM:
    vb.memory = "2048"
  # Esto hace que vaya más rápido:
    vb.customize [
        "storagectl", :id,
        "--name", "SATA Controller",
        "--hostiocache", "off"
    ]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "ansible_local" do |ansible|
    ansible.install_mode = "pip"
    ansible.version = "2.7.0"
    ansible.provisioning_path = "/var/www/mcbalcaldi"
    ansible.playbook = "/var/www/mcbalcaldi/provision/install.yml"
    ansible.inventory_path = "/var/www/mcbalcaldi/provision/environments/development/hosts"
    ansible.galaxy_role_file = "/var/www/mcbalcaldi/provision/requirements.yml"
    ansible.galaxy_roles_path = "/etc/ansible/roles"
    ansible.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force"
    ansible.raw_arguments = [
      "--extra-vars \"runtime_environment=development\"",
      "--private-key=.vagrant/machines/default/virtualbox/private_key"
    ]
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/var/www/mcbalcaldi", type: "rsync",
    mount_options: ["uid=1000", "gid=33"], rsync__exclude: [
      ".git/",
      "drush/contrib/",
      "vendor/",
      "web/core/",
      "web/modules/contrib/",
      "web/themes/contrib/",
      "web/profiles/contrib/",
      "web/libraries/",
      "web/sites/default/files/",
      "web/sites/simpletest/"
    ]
  config.vm.synced_folder "config", "/var/www/mcbalcaldi/config",
    type: "virtualbox", mount_options: ["uid=1000", "gid=33"]

  # Para redirigir credenciales de SSH.
  config.ssh.forward_agent = true
end
