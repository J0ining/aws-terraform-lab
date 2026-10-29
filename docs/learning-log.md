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
- **Learned** Use of variables between the root module and the rest of the modules. Use of data blocl
-  **Problem:** Trying to figure out moving values between modules and use for each to conditionate the creation of resources.
- **Diagnosis:**
- **Fix:**
- **Questions:**


- **Done:**
-  **Problem:**
- **Diagnosis:**
- **Fix:**
- **Questions:**