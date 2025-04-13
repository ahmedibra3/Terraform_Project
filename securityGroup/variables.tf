variable "VPC-ID" {
    description = "The VPC ID for the SG"
    type = string
}
variable "SG-Name" {
    description = "The SG Name"
    type = string  
}
variable "SSH-IP" {
    description = "The IP to allow ssh from"
    default = "0.0.0.0/0"
    type = string
  
}