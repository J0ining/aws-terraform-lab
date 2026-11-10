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


**Why:** I want to work with multi-AZ configuration to provide high availability (HA) and to work with multiple AZs


## Route tables
**Decision:** 1 public route table and 1 private route table

**Why:** This is good enough for a practice lab where I will just provide just one NAT Gateway so one private route table is enough


## Availability zones
**Decision:** The avaliability zone used are the first 2 AZs returned by aws_availability_zones data source selected using indexes.

**Why:** It's a simple configuration. For this lab practice I don't care which AZs are used for each subnet

**Alternatives:** If specific AZs are needed, use their names instead of indexes. Validate the names with contains against the data source list.

## NAT Gateway

**Decision:** One NAT Gatewat with one Elastic IP in the first public subnet available.

**Why:** There is no need for this lab for more NAT Gateway.

**Alternative:** In a production enviroment with multiple NAT Gateway to provide high availability, one private route table is needed for each NAT Gateway. Otherwise a single NAT is a single point of failure if the NAT's AZ goes down.


## ALB

**Decision:** One ALB for all the AZs

**Why:**  One is enough for high availability through all AZs


## ASG EC2 Instance


**Decision:** t3.micro instances. Instance specifications from data sources
**Why:**  

