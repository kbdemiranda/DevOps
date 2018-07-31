Vagrant.configure("2") do |config|

	config.vm.box = "hashicorp/precise32"
	# config.vm.box = "ubuntu_awss"
	# config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

	config.vm.provider :aws do |aws, override|
	    aws.access_key_id = "CHAVE_DE_ACESSO"
	    aws.secret_access_key = "CHAVE_SECRETA"

		aws.keypair_name = "devops"
		aws.ami = "ami-358c955c"
		aws.security_groups = ['devops']

		override.ssh.username = "ubuntu"
		override.ssh.private_key_path = "devops.pem"
	end

	config.vm.define :web do |web_config|
		web_config.vm.network "private_network", ip: "192.168.50.10"
		web_config.vm.provision "shell", path: "manifests/bootstrap.sh"
		web_config.vm.provision "puppet" do |puppet|
			puppet.manifest_file = "web.pp"
		end
		web_config.vm.provider :aws do |aws|
			aws.tags = { 'Name' => 'MusicJungle (vagrant)'}
		end
	end

end