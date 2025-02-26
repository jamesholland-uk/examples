# Variable to allow each deployment uniquely named and labelled
name_prefix = "vmseries-test"

# GCP variable values
gcp-project      = "my-project-name"
gcp-region       = "europe-west2"
gcp-zone         = "europe-west2-c"
credentials_file = "gcp.json"

# GCP Network variable values
mgmt-subnet-cidr    = "10.10.10.0/24"
outside-subnet-cidr = "10.10.20.0/24"
inside-subnet-cidr  = "10.10.30.0/24"
allowed_sources     = ["0.0.0.0/0"]

# PAN-OS VM-Series variable values
pan-os-version                        = "vmseries-flex-bundle2-1020"
ssh_key                               = "admin:ssh-rsa AAAA....37LTsS5zb2V user@machine" # This is an SSH public key. On Mac/Linux you may find this with "cat ~/.ssh/id_rsa.pub", or you may need/want to create a new SSH keypair first
dns_server_1                          = "8.8.8.8"
dns_server_2                          = "8.8.4.4"
panorama_primary                      = "cloud"              # Set to "cloud" when adopting into SCM
panorama_secondary                    = "cloud"              # Ignored if priarmy is set to "cloud"
dgname                                = "vmseries_gcp"       # Folder name when using SCM
tplname                               = "label:vmseries_gcp" # Label name when using SCM
vm-series-auto-registration-pin-id    = "abc123"
vm-series-auto-registration-pin-value = "abc123"
plugin-op-commands                    = "advance-routing:enable"
authcodes                             = "abc123"
