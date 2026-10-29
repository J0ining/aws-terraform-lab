variable "base_cidr_block"{
    type    = string
    description= "VPC CIDR"
}


variable "availability_zones_region"{
    type    = list(string)
    description= "availability zones in the region"
}