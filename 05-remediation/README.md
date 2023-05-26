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

# Loading Remediation Policies

Log back to the console then browse to `Admin > Controls > Repositories` then hit the `Add Repository` button. 

![Add Repository](../assets/02-add-repository.png)

Use the following parameters to add the repository: 

* Name: `Workshop Policies - Remediation`
* URL: `https://github.com/stacklet/aws-workshop`
* Branch name: `main`
* Policy Directories: `05-remediation/runtime`

[Next Step](../06-conclusion/README.md) | [Back to Top](../README.md)