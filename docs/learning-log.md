## 27/10/2027 

- **Done:** Check with fmt and validate. Cycle of init, apply and destroy
-  **Problem:** Error: creating EC2...api error Unsupported: The requested configuration is currently not supported. 
- **Diagnosis:** Check compatible instances: aws ec2 describe-instance-type-offerings
- **Fix:** Switch from t2.micro to t3.micro
- **Questions:**

## 28/10/2027 

- **Done:** Created network modules and aws_vpc resource. Call the module from "root module"
- **Learned** Checking documentation from Hashicorp to learn how the project structure and modules work. Use the registri to get the vpc resource.
-  **Problem:**
- **Diagnosis:**
- **Fix:**
- **Questions:**


## 29/10/2027 

- **Done:** Refactor to use variables and check with validate to add a subnet.
- **Learned** Use of variables between the root module and the rest of the modules. Use of data block
-  **Problem:** Trying to figure out moving values between modules and use for each to conditionate the creation of resources.
- **Diagnosis:**
- **Fix:**
- **Questions:**


## 30/10/2027 

- **Done:** 4 subnets created in the new vpc, with the distintion between private and public in code. Subnet data in root module and used int the network modules
- **Learned** Use of for_each. How to use it with more complex structures
-  **Problem:** Getting for_each to work with a list of objects. It just accepts set of string or maps.
- **Diagnosis:** My list of objects needs to comply with the rules so i need to refactor the list to a map or something else.
- **Fix:** The list remains the same. When the module wants to use it with for_each, I create a for loop to assign the objects a key value. tomap() works but isnt really necessary 
- **Questions:**


- **Done:**
-  **Problem:**
- **Diagnosis:**
- **Fix:**
- **Questions:**


## 03/10/2027 

- **Done:** Internet GW, 2 new route tables, 1 private and 1 public, including resources to create the associations between them. Route tables attached to corresponding subnets.
- **Learned** Use tags to assign private and public subnet. For_each resources
-  **Problem:** 
- **Diagnosis:** 
- **Fix:** 
- **Questions:**


- **Done:**
-  **Problem:**
- **Diagnosis:**
- **Fix:**
- **Questions:**