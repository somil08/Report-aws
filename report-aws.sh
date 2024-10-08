#!/bin/bash

###################################
# Author: Somil Rathore
# Date: 16th-Sep
# Version: v1
# This script will report the AWS resource usage
###################################

# Function to check if AWS CLI is installed
function check_aws_cli {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI not found. Please install AWS CLI and configure it."
        exit 1
    fi
}

# Report S3 buckets
function report_s3 {
    echo "Fetching S3 bucket information..."
    aws s3 ls
    echo "==========================================="
}

# Report EC2 instances
function report_ec2 {
    echo "Fetching EC2 instances information..."
    aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress]" --output table
    echo "==========================================="
}

# Report Lambda functions
function report_lambda {
    echo "Fetching Lambda functions information..."
    aws lambda list-functions --query "Functions[*].[FunctionName,Runtime,LastModified]" --output table
    echo "==========================================="
}

# Report IAM users
function report_iam_users {
    echo "Fetching IAM users information..."
    aws iam list-users --query "Users[*].[UserName,UserId,CreateDate]" --output table
    echo "==========================================="
}

# Main function
function main {
    check_aws_cli
    echo "AWS Resource Usage Report"
    echo "==========================================="
    
    report_s3
    report_ec2
    report_lambda
    report_iam_users
}

# Run main function
main
