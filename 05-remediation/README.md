# Remediation

Until this moment, Stacklet has only been used in "information" mode, ie. it is identifying governance issues either in the code or at runtime and reporting/notifying on them. 

However, Stacklet Platform can also orchestrate actions that will modify assets in their runtime to make the cloud more secure, compliance and/or efficient. 

And yes, before you ask, this introduces drift. If we use Terraform, then the next deploy will be revert the change. 
 
And yes, this is fine. 
In many real life situations, generating a tiny, temporary drift is a small price to pay to improve security quickly enough. The time to re-run a full CICD pipeline is very often a lot longer than the time required to infiltrate your infrastructure. 
And in other contexts it might not be appropriate at all. Carefully evaluating and integrating context in the decision making process of autoremediation is a key element of acceleration. 

But before we jump to the processes, let's have a look at the technology. 

# Policy Actions

Each resource type in C7n has a number of actions that may be executed against it. There are common actions (tagging for example), that apply to most or all of the resources, and specific actions, which only apply to a subset of services (remove a specific rule on a security group for example).

Actions are applied subsequently to filtering resources, and can be leveraged with all modes: 

* Pull Mode: From "Search and Flag", we move to "Search and Fix"
* Event Mode: Actions react to Create and/or Update events and apply to a single resource or a small batch of resources

# AWS IAM Permissions 

By default, policies only operate in Read Only mode. You must deploy a new set of permissions to run remediation policies.

Deploy the [CloudFormation template](./stacklet-remedation.cfn.yaml) in  `us-east-1`: 

```shell
cd 05-remediation
aws --region us-east-1 cloudformation deploy \
    --template-file stacklet-remediation.cfn.yaml \
    --parameter-override DestinationAccount=<DestinationAccountID> DestinationPrefix=ws-<DestinationAccountID> \
    --capabilities CAPABILITY_NAMED_IAM \
    --stack-name StackletEnablementRemediation
```

Extract the ARN of the role with 

```shell

```


# Loading Remediation Policies

Log back to the console then browse to `Admin > Controls > Repositories` then edit the repository. 

In the `Advanced Parameters > Policy Directories` add `,05-remediation/runtime` to the existing folder. 

Save, and scan the repository again. Create a new policy collection called `Remediation` that contains all the policies which names end in `prevent`, `remediate` and `protect`.

Now create a new binding to execute this new collection on the previous accounts. Make sure to set the `Security Context`  to the ARN you extracted in the previous paragraph. 
Also leave the `Dry Run` mode unticked. We actually want to run the actions.

Finally, hit the `Run Now` button. 

# Analyzing Results

From the binding page itself, pick a policy you know will have at least one remediation to run, such as the ELB Bad Headers one, and regularly refresh the execution tab until the new executions happen. 

When that's done, check the one that matched a resource and read the logs to discover which actions were taken. 

Now go to the web console of AWS, check the resource, and verify that it is now compliant with the policy. 


[Next Step](../06-conclusion/README.md) | [Back to Top](../README.md)