driveletters = ('a'..'z').to_a
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  config.vm.box = "centos/7"
  config.vm.define "minikube" do |kube|
    kube.vm.hostname="minikube"
  end
  host_vars= {}
  host_vars["minukube"]="minikube"
  config.vm.provider "libvirt" do |lv|
    lv.memory = "4096"
    lv.cpus = "4"
    lv.default_prefix = "gcs"
    lv.cpus = 4
    lv.memory = 4086
    lv.nested = false
    lv.cpu_mode = "host-passthrough"
    lv.volume_cache = "writeback"
    lv.graphics_type = "none"
    lv.video_type = "vga"
    lv.video_vram = 1024
    # lv.usb_controller :model => "none"  # (requires vagrant-libvirt 0.44 which is not in Fedora yet)
    lv.random :model => 'random'
    lv.channel :type => 'unix', :target_name => 'org.qemu.guest_agent.0', :target_type => 'virtio'

    lv.storage :file, :device => "vdb", :size => '20G'
    disks = []
        (2..4).each do |d|
          lv.storage :file, :device => "vd#{driveletters[d]}", :size => '1024G'
          disks.push "/dev/vd#{driveletters[d]}"
        end

  config.vm.network "forwarded_port",
      guest: 30000,
      host:  30000,
      auto_correct: true

  config.vm.network "forwarded_port",
      guest: 80,
      host:  80,
      auto_correct: true

  config.vm.network "forwarded_port",
      guest: 443,
      host:  443,
      auto_correct: true
    
  config.vm.provision :ansible do |ansible|
        ansible.playbook = "vagrant-playbook.yml"
        ansible.become = true

  end
end
end
