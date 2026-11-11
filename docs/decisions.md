# Design decisions

## VPC

**Decision:** CIDR: 10.0.0.0/16

**Why:** Large address range. Enough room for any subnet needed

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

**Why:** This is good enough for a practice lab where I will just just deploy one NAT Gateway so one private route table is enough


## Availability zones
**Decision:** The avaliability zone used are the first two AZs returned by aws_availability_zones data source selected using indexes.

**Why:** It's a simple configuration. For this lab practice I don't care which AZs are used for each subnet

**Alternatives:** If specific AZs are needed, use their names instead of indexes. Validate the names with contains against the data source list.

## NAT Gateway

**Decision:** One NAT Gatewat with one Elastic IP in the first public subnet available.

**Why:** The lab doesn't need more than one NAT Gateway.

**Alternative:** In a production enviroment with multiple NAT Gateway to provide high availability, one private route table is needed for each NAT Gateway. Otherwise a single NAT is a single point of failure if the NAT's AZ goes down.


## ALB

**Decision:** One ALB for all the AZs

**Why:**  One is enough for high availability across all AZs

## Security Groups

**Decision:** Traffic between tiers by referencing the source security group

**Why:**  It is easy to stablish communication between tiers and relevant in ASG instances where IP adresses change and it's easier to reference a group and only members of the group can connect with the ALB


## ASG EC2 Instances


**Decision:** t3.micro instances. Instance specifications from data sources.Fixed size of 2 instances across all AZs. IMDSv2 required using http_tokens= "required". Small nginx page created in user_data.sh that shows instance metadata
**Why:**  Basic instances to perform testing with an nginx server. 2 instances to test ALB functionality. http_tokens required to get metadata for security purposes

