# Laptop / Workstation Setup

## Download this repository

Clone the repository used for the workshop:

```shell
cd ~
git clone https://github.com/stacklet/aws-workshop
cd aws-workshop
```

## Download the docker image

```shell
docker pull public.ecr.aws/p9c6x6z1/stacklet/workshop:latest
docker tag public.ecr.aws/p9c6x6z1/stacklet/workshop:latest stacklet/workshop:latest
```

## Setup your credentials

A user has been created for you in an AWS account supervised by Stacklet, and credentials have been supplied to you separately. 

Use these credentials to configure your AWS CLI: 

```shell
cp .aws/credentials.template .aws/credentials
nano .aws/credentials
```

In this file, fill in the blanks after the `=` character. 

```init
[default]
aws_access_key_id=
aws_secret_access_key=
```

## Start your Docker container

Start the container with:

```shell
docker run –-rm -it -v ${PWD}:/root/ stacklet/workshop:latest
```

Then test that your credentials work properly with:

```shell
aws ec2 describe-regions
```

If you encounter any error, reach out! 


[Next Step](../01-policy-authoring/README.md) | [Back to Top](../README.md)