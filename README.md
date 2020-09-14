# VMWare-lab
Deploy ESXi, PfSense and VCSA 6.7 on Macbook pro and automate VM creation via terraform

### Steps to create VM Ware lab environment on Macbook pro (10 Gb RAM and 8 vCPU needed)

1. Download VMWare Fusion 10.x / 11.x
2. Download ESXi 6.7 ISO (by creating VMware account)
3. Create a VM (from Fusion) using ESXi ISO and open it in web browser
4. Download PfSense ISO (required for DNS and Firewall)
5. Create Pfsense VM from ESXi browser
6. Configure DNS on Esxi to point to PfSense VM
7. Download VCSA 6.7 ISO and extract locally on Mac (where OVF file present)
8. Create VCSA VM from ESXi browser by using OVF template

If all above are successful you should have all 3 running and accessible via webbrowser-

## Overall Deployment Architecture


a) ESXi server

b) PFSense server

c) VCSA Server

-----------

## Automation

1. Automate VM template creation via Hashicorp Packer

2. Automate VM creation using above template via Terraform
