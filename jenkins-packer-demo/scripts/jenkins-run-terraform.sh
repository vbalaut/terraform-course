#!/bin/bash
set -ex
cd jenkins-packer-demo
S3_BUCKET=`aws s3 ls |grep terraform-state |tail -n1 |cut -d ' ' -f3`
sed -i 's/terraform-state-xx70dpnh/'${S3_BUCKET}'/' backend.tf
aws s3 cp s3://${S3_BUCKET}/amivar.tf amivar.tf
terraform apply -auto-approve -var APP_INSTANCE_COUNT=1 -target aws_instance.app-instance
