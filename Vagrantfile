Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.define "nodeA" do |primary|
    primary.vm.network :private_network, ip: "192.168.111.11"
    primary.vm.network :forwarded_port, guest: 22, host: 64673, id: "ssh", auto_correct: true
  end

  config.vm.define "nodeB" do |replica|
    replica.vm.network :private_network, ip: "192.168.111.12"
    replica.vm.network :forwarded_port, guest: 22, host: 64674, id: "postgres", auto_correct: true
  end

  config.vm.provision "file", source: "./ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"

end
