variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"

}

 

variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"

}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

}