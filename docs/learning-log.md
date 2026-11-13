## 27/10/2026 

- **Done:** Check with fmt and validate. Cycle of init, apply and destroy
-  **Problem:** Error: creating EC2...api error Unsupported: The requested configuration is currently not supported. 
- **Diagnosis:** Check compatible instances: aws ec2 describe-instance-type-offerings
- **Fix:** Switch from t2.micro to t3.micro

## 28/10/2026 

- **Done:** Created network modules and aws_vpc resource. Call the module from "root module"
- **Learned** Checking documentation from HashiCorp to learn how the project structure and modules work. Use the registry to get the vpc resource.


## 29/10/2026 

- **Done:** Refactor to use variables and check with validate to add a subnet.
- **Learned** Use of variables between the root module and the rest of the modules. Use of data block
-  **Problem:** Trying to figure out moving values between modules and use for each to conditionate the creation of resources.


## 30/10/2026 

- **Done:** 4 subnets created in the new vpc, with the distinction between private and public in code. Subnet data in root module and used int the network modules
- **Learned** Use of for_each. How to use it with more complex structures
-  **Problem:** Getting for_each to work with a list of objects. It just accepts set of string or maps.
- **Diagnosis:** My list of objects needs to comply with the rules so i need to refactor the list to a map or something else.
- **Fix:** The list remains the same. When the module wants to use it with for_each, I create a for loop to assign the objects a key value. tomap() works but isn't really necessary 


## 03/11/2026 

- **Done:** Internet GW, 2 new route tables, 1 private and 1 public, including resources to create the associations between them. Route tables attached to corresponding subnets.
- **Learned** Use tags to assign private and public subnet. For_each resources



## 04/11/2026 


- **Done:** Outputs for vpc_id, subnets_info and public/private subnets ids. Inputs validations for the subnet data in main.tf in the root module
- **Learned** More uses of "for" expression in the contex of outputs to select especific data from a list and used in validation with alltrue to validate multiple objects in a list.

## 05/11/2026 


- **Done:** Set up Github Actions Workflow to do terraform validations (fmt, validate, tflint and checkov). Corrections of error from TFLint and Checkov.
- **Learned** Basic configuration of workflow in the repository. Including structure, configure triggers and steps that will follow.
-  **Problem:** TFLint points out the lack of provider requirement in child module. Checkovs finds multiples problems regarding AWS provider
- **Fix:** Add provider requirements in child module. Add aws_default_security_group  and skip using #checkov:skip other 2 problemas after being considered as an exception for this lab.



## 06/11/2026 


- **Done:** ALB created. TODO: egress rules when the reources are created. Checked that DNS returns 503 as there is no destinations yet.
- **Learned** Basic configuration for an ALB. First interaction between modules using the root modules to share de output values from the network module to the alb module


## 09/11/2026 


- **Done:** Compute module. WIP. Still need to add NAT and ASG.
- **Learned** 


## 10/11/2026 


- **Done:** NAT Gateway with Elastic IP created and private route table with added rule to route traffic to NAT Gateway. Configure AMI data source for ec2 instances
- **Learned:** Looked up available AMIs in a region and setting up parameters required for the data source. Created a NAT Gateway in a specific subnet. Add the NAT Gateway to a rule in the route table.

## 11/11/2026
- **Done:** ASG with launch template. Ubuntu 24.04, t3.micro and IMDSv2 required. user_data script for nginx installation and serves instances metadata (instance id, hostname and AZ). Two instances across two AZs, included in the ALB target group.
- **Learned:** ASG registration reference target group so no need for attachment resource.
-  **Problem:** Error creating ASG, no valid target group.
- **Diagnosis:** It was using ALB arn, not the targets group arn
- **Fix:** Modify alb module output to use target group arn and share it in root module to the compute module.

## 12/11/2026
- **Done:** Database module with db instance resource. Using Postgresql engine version 18, a db.t3.micro instance with gp3 and 20GB. Implemented connection from ec2 instances using their security groups.
- **Learned:** Checked engine and engine versions available and their specifications in the region I'm deploying. Basic connectivity of ec2 instances and rds databases using security groups.
- **Pending:** Check that connectivity from ec2 instances to database works properly.

## 13/11/2026
- **Done:** Fixed the Checkov problems reported by the workflow. Fixed the ones that were free and recommended by the guide from checkov. Skip the ones that didn't apply to the lab or incur costs
- **Learned:** Follow checkov recommendations and guides and judge if the problem describe apply to the lab. In that case choose to skip or resolve the problem. Skipping HTTPS related problems because they don't apply and adding descriptions when it was required.
- **Pending:** Check that connectivity from ec2 instances to database works properly.


## Template
- **Done:**
- **Learned:**
-  **Problem:**
- **Diagnosis:**
- **Fix:**
- **Questions:**