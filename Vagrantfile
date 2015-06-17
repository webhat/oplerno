# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/precise64'
  #config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.vm.provision 'shell', path: 'bin/provision.sh'
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end
  config.vm.provider 'vmware_fusion' do |vm|
    vm.vmx['memsize'] = '1024'
  end
  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = '../oplerno_puppet/manifests'
    puppet.module_path = '../oplerno_puppet/modules'
    puppet.manifest_file = 'site.pp'
    puppet.options = '--verbose --debug'
    puppet.facter = {
      # XXX: Dummy value
      'new_relic_license_key' => 'a'*40
    }
  end
end

