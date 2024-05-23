# Cloud computing basics
Exercise one for the subject basics of cloud computig.
Which are solved with Terraform.
Part of the third semester computer science. 

There were 2 tasks: 
  1. Creating an EC2 instance on AWS which run an own web application.
  2. Uploading a website to an S3 bucket, which was then made available with CloudFront.

## Set Environment variables
Are necessary to communicate with the AWS API.
```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_SESSION_TOKEN=""
```

## Terraform commands
To create the application:
```
terraform apply -auto-approve
```
To delete the application:
```
terraform destroy -auto-approve
```
