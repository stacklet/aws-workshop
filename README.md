# Introduction

Welcome to this workshop about Stacklet, the Enterprise Grade Governance as Code Platform. 

This workshop is composed multiple steps, during which you will iterate between the multiple personas that Stacklet can help in companies, from security SMEs to application developers. Workshop steps are mapped to Git branches, which contain the necessary files to understand and complete the tasks at hand. 

We hope you have a pleasant experience today, and that this workshop convinces you that Stacklet could be a fit in your organization. 

# Context of the workshop

Today, you will impersonate different personas working at ACME.inc on a new project: deliver a great new blog for the company to promote its products and services. 

We are at the stage where engineering research have already happened. At this point, the organization has decided that the solution shall be powered by Wordpress, and running on AWS. 
The product team is now asking for a prototype in order to run some user research, and various teams collaborate to prototype the experience. 

ACME.inc are fervent users of Stacklet, which they use throughout their entire Software Development Lifecycle. Today, you will successively impersonate all the personas at ACME.inc who interact almost on a daily basis with Stacklet. 

# Laptop Setup

Before we start hacking into the details, let's make sure that you have all the tools in place to run all the activities of this workshop fluidely. 

Take a few minutes to go through the [installation guide](./00-intro/01-laptop-setup.md)

# Workshop Activities

## Introduction to Stacklet

Before we start hacking our way through developing and deploying a great solution for our customers, let's take a few minutes to explain the concepts and objects in Stacklet Platform. 

* Governance as Code and Policies
* Binding
* Data Analytics (AssetDB)
* Actions

## [Policy Authoring and Deployment]([./01-policy-authoring/README.md])

### Shift Left Policy Authoring

In this phase, we take a closer look at authoring policies for Terraform. As a security expert, you define a set of Non Functional Requirements, and encode them into policies that will verify that the infrastructure code matches your requirements. 

### Runtime Policy Authoring

You now dive into securing the runtime of the infrastructure, once it's been deployed via Terraform. You know that there are some break glass accounts and that it is important to keep an eye on resources even after they have been deployed. 

## [Deploying Runtime Policies to Protect your Cloud]([./02-policy-deployment/README.md])

How that we have policies in place, let's deploy them in Stacklet, to make sure that your cloud is monitored in real-time, and that pre-existing assets are also taken care of. 

## [Development of Infrastructure with Stacklet]([./03-infrastructure-deployment/README.md])

### Infrastructure as Code

You are now a member of the DevOps team in charge of building the Wordpress solution. The policies written before are effectively your NFRs and thankfully you are getting them very early on in your development cycle. 

### Runtime - Change Management

Many organizations prevent the use of console or CLI but under very special circumstances. Also many organizations experience special circumstances on quite a regular basis. Let us see how Stacklet can help keeping track of the changes made in the runtime, notify stakeholders and encourage them to take action. 

## [Reporting](./04-reporting/README.md)

### Curated Experience - Stacklet Console

Discover how Stacklet console presents results at the policy level and flags resources that are non compliant

### Custom Experience - Data Analysis

Stacklet provides you with an access to the raw data that the platform and AssetDB generate, including cost (billing) data from your Cloud Provider. This is hugely valuable when you want to discover issues in "Serendipity Mode". Let's discover some interesting queries you might run. 

## Cleaning up the environment



## Final Words

Let's take some time to reflect on the session, what we learnt, and next best actions



