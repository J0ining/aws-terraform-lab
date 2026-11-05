# Design decisions

## VPC

**Decision:** CIDR: 10.0.0.0/16
**Why:** Large address range. It fits any subnet may I need

## Internet gateway

**Decision:** One internet gateway attached to the VPC
**Why:** A new VPC has no internet access so an internet gateway needs to be attached.

## Subnets
**Decision:**
AZ A: 1 private subnet and 1 public subnet
AZ B: 1 private subnet and 1 public subnet


**Why:** I want to work with multi-AZ configuracion to provide high availability (HA) and to work with multiple AZs so I can learn to configure resources that use multiple AZs


## Route tables
**Decision:** 1 public route table and 1 private route table
**Why:** This is good enough for a practice lab where I will just provide just one NAT or none so there is no need for more private route tables


## Availability zones
**Decision:** The avaliability zone used are the first 2 AZs returned by aws_availability_zones data source selected using indexes.
**Why:** It's a simple configuration. For this lab practice I care which AZs are used for each subnet

**Alternatives:** If specific AZs are needed, use their names instead of indexes. Validate the names with contains against the data source list.

