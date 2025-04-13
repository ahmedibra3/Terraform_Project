variable "VPC-ID" {
    description = "The VPC ID"
    type = string
}
variable "IGW-ID" {
    description = "Internet Gateway ID"
    default = ""
    type = string
}
variable "NAT-ID" {
    description = "NAT Gateway ID"
    default = ""
    type = string  
}
variable "RT_Name" {
    default = "Project_RT"
    type = string
}