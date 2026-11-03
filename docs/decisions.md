# Design ideas

## VPC

CIDR: /16

# Internet gateway

One attached to the vpc

## Subnets

AZ A: 1 privates subnet and 1 public subnet
AZ B: 1 private subnet and 1 public subnet

Subnets created just looking the 2 first position in the data source block


# Route tables

1 public route table and 1 private route table, just one NAT in dev so no need for more private route table