variable "Target-Group-Name" {
    description = "The name of the target group"
    type        = string
}
variable "VPC-ID" {
    description = "The ID of the VPC"
    type        = string
}
variable "LB-Name" {
    description = "The name of the load balancer"
    type        = string
}
variable "LB-Sec-Group" {
    description = "The ID of the security group for the load balancer"
    type        = list(string)
}
variable "SubNet-ID" {
    description = "The ID of the subnet for the load balancer"
    type        = list(string)
}
variable "Internal-LB" {
    description = "Whether the load balancer is internal or external"
    type        = bool
    default     = false
}