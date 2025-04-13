variable "VPC_ID" {
    description = "The VPC ID"
    type = string
}
variable "CIDR_Subnet" {
    description = "The Subnet CIDR block"
    type = string
}
variable "Subnet_Name" {
    description = "The Subnet Name"
    type = string
}
variable "Availability_Zone" {
    description = "The AZ For The subnet"
    type    = list(string)
    default = ["us-east-1a", "us-east-1b"]
}

variable "Public_or_Private" {
    description = "true for a public subnet or false for a private one"
    default = false
    type = bool
}

variable "RT-ID" {
    description = "Route Table ID"
    type = string
}