# variable for key pair
variable "ec2_key_pair" {
  type = object({
    key_name = string
    key_value = string 
  })
  default = {
    key_name = "new_key"
    key_value = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTLN0GZI1VmPTBC6oFThcrRNTSGRrJ35StdRlvg7dJt mdaas@Aasim"
  }
}
#variable for instance type
variable "ec2_instance_type" {
    default = "t2.medium"
    type = string
}

# variable for AMI id 
variable "ec2_ami_id" {
    default = "ami-0e35ddab05955cf57"
    type = string
}

#variable for root storage
variable "ec2_root_storage" {
    type= object({
      size = number
      type = string
    })
    default = {
        size = 30
        type = "gp3"
    }
  
}
