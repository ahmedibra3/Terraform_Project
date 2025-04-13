variable "Vpc-cidr" {
    description = "The CIDR of The VPC"
    # default = "10.0.0.0/16"
    type = string
}
variable "VPC-Name" {
  description = "The VPC Name"
  default = "Main_VPC"
  type = string
}

variable "IGW-name" {
    description = "Internet GateWay Name"
    default = "Project_IGW"
    type = string
}