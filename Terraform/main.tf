provider "vsphere" {
  user = "administrator@vsphere.local"
  password = "374682ajC!!"
  vsphere_server = "10.0.0.40"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
    name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
    name = "datastore3"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "iso_datastore" {
    name = "datastore3"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
    name = "resource pool"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
    name = "VM Network"
    datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
    name = "Terraform-CentOS-DevPacker"
    resource_pool_id = data.vsphere_resource_pool.pool.id 
    datastore_id = data.vsphere_datastore.datastore.id

    num_cpus = 16
    memory = 16384
    guest_id = "centos8_64Guest"
    wait_for_guest_ip_timeout = 0

    network_interface {
        network_id = data.vsphere_network.network.id
    }

    disk { 
        label = "disk0"
        size = 25
    }
    cdrom {
        datastore_id = data.vsphere_datastore.iso_datastore.id
        path = "ISO/CentOS-8.3.2011-x86_64-dvd1.iso"
    }
  
}
