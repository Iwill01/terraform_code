# Key Pair Resource
resource "aws_key_pair" "ec2_key" {
  key_name   = "Your Key Name" # Replace with your desired key name
  public_key = file("YourPublicKey.pub") # Ensure the key file is in the same directory
}
#Default VPC for ec2 instance 
resource "aws_default_vpc" "default" {}

# security groups allow all traffic in {ssh.http,5000} and out 
resource "aws_security_group" "ec2_security_groups" {
    name = "myec2_security_group"
    vpc_id = aws_default_vpc.default.id


  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  

  egress {
    description = "Allow All Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
# EC2 instance resources 
resource "aws_instance" "voterapp_instance" {
    ami = var.ec2_ami_id # ubuntu
    instance_type = var.ec2_instance_type
    key_name = aws_key_pair.ec2_key.key_name
    security_groups = [aws_security_group.ec2_security_groups.name]
    user_data = file("userdata.sh") # user data script to install packages and run the app


    # Root storage
    root_block_device {
      volume_size = var.ec2_root_storage.size
      volume_type = var.ec2_root_storage.type
    }
    # tags
    tags = {
      Name = "voterapp_instance"
    }
  
}
# Output Public Ip of my ec2 instance
output "instance_public_ip" {
    value = aws_instance.voterapp_instance.public_ip
}
# output for Public DNS
output "instance_public_dns" {
    value = aws_instance.voterapp_instance.public_dns
}