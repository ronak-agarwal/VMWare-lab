# ======================== #
# VMware VMs configuration #
# ======================== #

vm-count = "1"
vm-name = "ubuntu8"
vm-template-name = "ubuntu"
vm-cpu = 1
vm-ram = 1024
vm-guest-id = "ubuntu64Guest"

# ============================ #
# VMware vSphere configuration #
# ============================ #

# VMware vCenter IP/FQDN
vsphere-vcenter = "vc01.localdomain.xx"

# VMware vSphere username used to deploy the infrastructure
vsphere-user = "administrator@localdomain.xx"

# VMware vSphere password used to deploy the infrastructure
vsphere-password = "Welcome123!"

# Skip the verification of the vCenter SSL certificate (true/false)
vsphere-unverified-ssl = "true"

# vSphere datacenter name where the infrastructure will be deployed
vsphere-datacenter = "Newcastle"

# vSphere cluster name where the infrastructure will be deployed
vsphere-cluster = "Cluster01"

# vSphere Datastore used to deploy VMs
vm-datastore = "datastore1"

# vSphere Network used to deploy VMs
vm-network = "VM Network"

# Linux virtual machine domain name
vm-domain = "localdomain.xx"
