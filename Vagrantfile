# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    # Give the box to have 1GB memory
    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    # Create the Jenkins VM
    config.vm.define "jenkins" do |jenkins|
        jenkins.vm.hostname = "jenkins"
        jenkins.vm.box = "ubuntu/trusty64"
        jenkins.vm.network "private_network", ip: "192.168.2.2", :adapter => 2

        # mount directories
        jenkins.vm.synced_folder "./srv/jenkins", "/srv/"

        # mount links git folder for now
        # this is kind of risky
        jenkins.vm.synced_folder "../web/links", "/var/links"

        # bootstrap salt
        jenkins.vm.provision :shell, path: "provision/jenkins.sh"
    end

    # Create the target VM
     config.vm.define "web" do |web|
        web.vm.hostname = "web"
        web.vm.box = "ubuntu/trusty64"
        web.vm.network "private_network", ip: "192.168.2.3", :adapter => 2

        # mount directories
        web.vm.synced_folder "./srv/web", "/srv/"

        # bootstrap salt (minion!)
        web.vm.provision :shell, path: "provision/web.sh"
    end
end