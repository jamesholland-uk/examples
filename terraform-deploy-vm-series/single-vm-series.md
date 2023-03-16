# Single VM-Series
AWS, Azure and GCP examples of creating just a VM-Series, with PAYG bundle 2 licensing. No other compute or services. No bootstrapping or Panorama attachment (although the code could be modified to include those options if you wish).

This is mostly aimed at Palo Alto Networks staff and partners, such as Systems Engineers, who just want a quick way to spin up a VM-Series to test, validate or demonstrate something with an easily disposable PAN-OS device.

Another aim is to show simple usage of the [published Palo Alto Networks modules for VM-Series](https://registry.terraform.io/modules/PaloAltoNetworks/vmseries-modules).

## Instructions
Within each of the folders per cloud provider:
- Rename `example.tfvars` to `terraform.tfvars`, and change the variable values in that file to suit your deployment
- Run terraform init, plan, and apply

## Folders per cloud provider
- [Single VM-Series in AWS](aws-single-vm-series/README.md)
- [Single VM-Series in Azure](azure-single-vm-series/README.md)
- [Single VM-Series in GCP](gcp-single-vm-series/README.md)

## Usage considerations
- With the aim of making this as simple as possible, authentication to the cloud provider is done with credentials either  in the `terraform.tfvars` file (AWS, Azure) or stored locally in the folder (GCP). SSH keys for initial authentication to the VM-Series are in the `terraform.tfvars` (AWS, GCP). This is not production best-practice, and care should be taken to protect these credentials.
- The easiest route to usage is to install Terraform locally on your machine, download the example code from this repository, and go. Terraform state will be local on your machine. This again is not production best practice, but will work. The code could be modified to use remote state, and Terraform could be executed remotely through a pipeline or workflow in GitHub, Terraform Cloud, amongst many many other places.
- When deciding which PAN-OS version to deploy for your VM-Series, you may wish to my [other repo's lists of available PAN-OS base images per cloud service provider](https://github.com/jamesholland-uk/pan-os-csp-versions#the-lists)
- Should you fork or copy this repository, and want to check it in to a VCS, not that using [Checkov](https://www.checkov.io) will give you the ability to not commit code including secrets such as cloud provider credentials. Checkov will also tell you that the code in these examples has other best practice violations, which is known and accepted due these examples being targeted for non-production use
