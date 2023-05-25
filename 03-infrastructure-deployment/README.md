# Introduction

You are now a member of a DevOps team at ACME.inc

Recently, a new initiative was launched and requires a new website. After careful consideration of several solutions, the decision was made to use Wordpress as the technology for this project. 

Wordpress is a 3 tiers application, with a webserver serving a PHP application, backed by a SQL database. A very simplistic architecture for this solution is presented on the below diagram: 

![solution architecture](../assets/aws-architecture.png)

In the first iteration of the design, the team wants to come up with something simple to accelerate the work of web designers and give them a platform to experiment with. 
ACME.inc is a very security focused organization. Even if this is an early project, the security team has been involved right away, and came up with a short list of Non Functional Requirements that are required throughout the lifecycle of the project: 

* Everything that can be encrypted must be encrypted, in flight and at rest
* Bad headers must never reach the application
* Databases shall not use the default communication port
* Under no circumstances should anyone by able to SSH into an instance from the internet

The Security Team did encode their requirements into c7n-left policies, and include them in the Git repository that the DevOps team uses for their work. You are now ready to get started. 

# Before you start

The code for this section is available in the folder `03-polinfrastructure-deployment`. 

# Writing the Infrastructure Code

## Getting Started

You quickly come up with a base made of a simple network infrastructure with a VPC, public subnets for the frontends and private subnets for backend and databases. 

You then decide to start working on the database. You know it will be tricky because the Security Team had some requirements for it. 

* Everything that can be encrypted must be encrypted, in flight and at rest
* Databases shall not use the default communication port

You come up with a first version of the code

```shell
cd 03-infrastructure-deployment
git checkout infra/step-1
```

Before you commit your code, you want to make sure that it works. You run the validation command against your code: 

```shell
c7n-left run -d . -p ../01-policy-authoring/iac
```

Which immediately indicates that it's not yet completely perfect. 

```shell
Running 7 policies on 60 resources
rds-using-default-port - terraform.aws_db_instance
  Failed
  Reason: RDS should not use the default port (an attacker can easily
guess the port). For engines related to Aurora, MariaDB or
MySQL, the default port is 3306. PostgreSQL default port is
5432, Oracle default port is 1521 and SQL Server default port is
1433.

rds-storage-not-encrypted - terraform.aws_db_instance
  Failed
  Reason: RDS Storage should be encrypted, which means the attribute 'storage_encrypted' should be set to 'true'
Evaluation complete 0.03 seconds -> 2 Failures
                            Summary - By Policy                             
┏━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━┓
┃ Severity ┃ Policy                                    ┃ Result            ┃
┡━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━┩
│ high     │ rds-storage-not-encrypted                 │ 1 failed 0 passed │
│ low      │ rds-using-default-port                    │ 1 failed 0 passed │
└──────────┴───────────────────────────────────────────┴───────────────────┘

Ooooups! Thankfully, the policies told us where to look. Fix the code in `rds.tf` and `variables.tf` to encrypt the storage and make sure that the instance port isn't the actual default MySQL port. 3307 is a viable option.  

Once you have the changes in place, run the c7n-left command again: 

```shell
c7n-left run -d . -p policies

┏━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━┓
┃ Severity ┃ Policy                                    ┃ Result   ┃
┡━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━┩
│ high     │ rds-storage-not-encrypted                 │ 1 passed │
│ low      │ rds-using-default-port                    │ 1 passed │
└──────────┴───────────────────────────────────────────┴──────────┘
```

Great! Now you know that you're on the right track! 

Before moving forward, take some time to review the policies stored in the `./policies` folder. Observe how they inform your terraform code by providing guardrails and documentation pointers.

## Final infrastructure

Once you understand the basics of policies, you immediately start hacking your way into adding more resources such as your autoscaling group and load balancers

```shell
git checkout infra/step-2
terraform init
```

Check the results and try to understand the issues in the Terraform code and how to fix them. 

You can deploy at any point with the sequence of commands:

```shell
terraform plan
terraform apply
```

Because we added policies that react to the creation of assets, and we made sure to send emails to notify you, you should get messages in your inbox if you do that prior to have fixed all the issues in the code. 

Make sure to fix all the files (ie. remove the comments in most cases) to arrive to a point where all policies pass and your code is compliant with the Non Functional Requirements, then redeploy a final time. 

# Conclusion

As a DevOps, you have now experienced how using Stacklet provides guardrails in both the infrastructure development phase and around the deployment phase. 

You will now go back to your security persona and discover how you can analyze results. 

[Back to Top](../README.md)