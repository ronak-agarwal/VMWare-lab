# VMWare-lab
Deploy ESXi 6.0, PfSense 2.4.5 and VCSA 6.7 on Macbook pro and automate VM creation via terraform

### Steps to create VM Ware lab environment on Macbook pro (12 Gb RAM, 8 vCPU and 60 Gig Disk needed)

1. Download VMWare Fusion 10.x / 11.x
2. Download ESXi 6.7 ISO (by creating VMware account)
3. Create a VM (from Fusion, esxi01 hostname) using ESXi ISO and open it in web browser
4. Download PfSense ISO (required for private DNS and Firewall)
5. Create Pfsense VM (fw01 is hostname) from ESXi browser
6. Configure DNS on Esxi to point to PfSense VM
7. Download VCSA 6.7 ISO and extract locally on Mac (where OVF file present)
8. Create vCenter Server - VCSA VM (vc01 hostname) from ESXi browser by using OVF template

List of ISOs -

```hcl
VMware-VMvisor-Installer-6.0.0.update03-5050593.x86_64.iso
pfSense-CE-2.4.5-RELEASE-p1-amd64.iso
VMware-VCSA-all-6.7.0-8217866.iso
CentOS-7-x86_64-Minimal-2003.iso
ubuntu-18.04.4-server-amd64.iso
```

If all above are successful you should have all 3 running and accessible via webbrowser-

## Overall Deployment Architecture

[![deployment.png](https://github.com/ronak-agarwal/VMWare-lab/blob/master/png-img/deployment.png)]()

-------------

a) ESXi server
[![esxi.png](https://github.com/ronak-agarwal/VMWare-lab/blob/master/png-img/esxi.png)]()

Network Adaptors on Fusion and ESXi
[![fusion-network.png](https://github.com/ronak-agarwal/VMWare-lab/blob/master/png-img/fusion-network.png)]()

Fusion networking ::

```hcl
WKMGB2980242:~ ronagarw$ cat /Library/Preferences/VMware\ Fusion/networking
VERSION=1,0
answer VNET_1_DHCP yes
answer VNET_1_DHCP_CFG_HASH 3CEFE22A042C9A85EFE871076AAC060660EAFEBF
answer VNET_1_HOSTONLY_NETMASK 255.255.255.0
answer VNET_1_HOSTONLY_SUBNET 192.168.138.0
answer VNET_1_VIRTUAL_ADAPTER yes
answer VNET_2_DHCP no
answer VNET_2_DHCP_CFG_HASH E423C68CC372D5F8A4D07ADB8D9370CC5F148CE2
answer VNET_2_DISPLAY_NAME vSphere
answer VNET_2_HOSTONLY_NETMASK 255.255.255.0
answer VNET_2_HOSTONLY_SUBNET 10.1.1.0
answer VNET_2_VIRTUAL_ADAPTER yes
answer VNET_3_DHCP no
answer VNET_3_DHCP_CFG_HASH 1D68FB8DDA6D36F24F7E16738EA340293510F850
answer VNET_3_DISPLAY_NAME WAN
answer VNET_3_HOSTONLY_NETMASK 255.255.255.0
answer VNET_3_HOSTONLY_SUBNET 198.18.0.0
answer VNET_3_NAT yes
answer VNET_3_NAT_PARAM_UDP_TIMEOUT 30
answer VNET_3_VIRTUAL_ADAPTER yes
answer VNET_8_DHCP yes
answer VNET_8_DHCP_CFG_HASH 8633DB9DCA18383E7710078EA9D4AABC2F0E099B
answer VNET_8_HOSTONLY_NETMASK 255.255.255.0
answer VNET_8_HOSTONLY_SUBNET 192.168.177.0
answer VNET_8_NAT yes
answer VNET_8_VIRTUAL_ADAPTER yes
```

Commands to stop / start Fusion network service

```hcl
sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --stop
sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --start
```


b) PFSense server
[![pfsense.png](https://github.com/ronak-agarwal/VMWare-lab/blob/master/png-img/pfsense.png)]()


My laptop /etc/hosts

```hcl
10.1.1.11 esxi01.localdomain.xx
10.1.1.12 esxi02.localdomain.xx
10.1.1.13 esxi03.localdomain.xx
10.1.1.101 vc01.localdomain.xx
10.1.1.251 fw01.localdomain.xx
```


c) VCSA Server
[![vc.png](https://github.com/ronak-agarwal/VMWare-lab/blob/master/png-img/vc.png)]()

```hcl
https://vc01.localdomain.xx:5480/login (for configuration)
https://vc01.localdomain.xx/ui
```

-----------

## Automation

1. Automate VM template creation via Hashicorp Packer

- Need Packer 1.5.x (as from 1.6.x HCL2 is used so you will have to change json template)
- We'll use vsphere-iso builder-type in packer API, this is to build VM snapshot (Eg CentOS)
- Sample json for packer is inside /packer/

> Ubuntu : packer build -var-file=variables.json ubuntu8.json


TODO - Packer script still failing due to local device0 mounting issue, need to investigate, but you can manually shutdown and create template from any running VM (Eg- Ubuntu)


2. Automate VM creation using above template via Terraform

> cd /terraform/VM/ubuntu/

> terraform init

> terraform apply

### TODOs

1. Create K8S cluster on CentOS VMs (1 master, 1 worker)
2. Deploy Web application on k8s
3. Automate ESXi > VMs > K8S > Web-app all in one go (combination of ansible, terraform, helm)

### Some Links
https://www.settlersoman.com/how-to-expand-vmfs-datastore-from-the-command-line-cli-on-vsphere-5-x-and-6-x/

https://graspingtech.com/install-vmware-vpshere-esxi-mac/

https://graspingtech.com/build-vsphere-lab-vmware-fusion-part-1/

https://graspingtech.com/ansible-deploy-vmware-vm/

K8S setup - https://medium.com/@genekuo/setting-up-a-multi-node-kubernetes-cluster-on-a-laptop-69ae3e3d0f7c
