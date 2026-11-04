variable "base_cidr_block" {
  type        = string
  description = "VPC CIDR"
}


variable "availability_zones_region" {
  type        = list(string)
  description = "availability zones in the region"
}

variable "subnets_data" {
  type = list(
    object(
      {
        cidr = string
        az   = number
        type = string
      }
    )
  )

  description = "Data in order to create a subnet"

  validation {
    condition     = alltrue([for subnet in var.subnets_data : can(cidrnetmask(subnet.cidr))])
    error_message = "Invalid CIDR values: ${join(", ", [for k in var.subnets_data : k.cidr if !can(cidrnetmask(k.cidr))])}."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets_data : contains(["public", "private"], subnet.type)])
    error_message = "Invalid type with values: ${join(", ", [for k in var.subnets_data : k.type if !contains(["public", "private"], k.type)])}."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets_data : length(var.availability_zones_region) > subnet.az && subnet.az >= 0])
    error_message = "Invalid AZ index with values: ${join(", ", [for k in var.subnets_data : k.az if !(length(var.availability_zones_region) > k.az && k.az >= 0)])}."
  }

}