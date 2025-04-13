variable "instance-type" {
    description = "Ec2 Type"
    default = "t2.micro"
    type = string
}
variable "Subnet-ID" {
    description = "Subnet ID for The EC2"
    type = string
}

variable "Security-Group-ID" {
    description = "The ID of the security group to associate with the EC2 instance"
    type        = string
}
variable "instance-name" {
    description = "The name of the EC2 instance"
    type        = string
}
variable "Remote-Exec" {
    description = "The provisioner script to run on the EC2 instance"
    type        = list(string)
    default     = null
}
variable "Private-key" {
    description = "The path to the private key file"
    type        = string
    default     = ""
}
variable "user-data" {
    description = "The user data script to run on the EC2 instance"
    type        = string
    default     = ""
  
}
variable "Enable-Remote" {
  description = "Enable or disable the remote-exec provisioner"
  type        = bool
  default     = false
}
variable "Target-Group-arn" {
  description = "The ID of the Target Group to attach the EC2 instance to"
  type        = string
}