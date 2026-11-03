#!/usr/bin/env bash
set -euo pipefail

VPC_NAME="${1:-Main VPC}"

VPC_ID=$(aws ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=${VPC_NAME}" \
  --query 'Vpcs[0].VpcId' --output text)

if [[ -z "$VPC_ID" || "$VPC_ID" == "None" ]]; then
  echo "No VPC found with Name='${VPC_NAME}'"
  exit 1
fi
echo "VPC: ${VPC_ID}"

echo; echo "== Subnets =="
aws ec2 describe-subnets --filters "Name=vpc-id,Values=${VPC_ID}" \
  --query 'Subnets[].{ID:SubnetId,Name:Tags[?Key==`Name`]|[0].Value,Type:Tags[?Key==`Type`]|[0].Value,AZ:AvailabilityZone,CIDR:CidrBlock}' \
  --output table

echo; echo "== Route tables =="
aws ec2 describe-route-tables --filters "Name=vpc-id,Values=${VPC_ID}" \
  --query 'RouteTables[].{Name:Tags[?Key==`Name`]|[0].Value,Subnets:Associations[].SubnetId,Routes:Routes[].[DestinationCidrBlock,GatewayId]}' \
  --output json

echo; echo "== Internet gateway =="
aws ec2 describe-internet-gateways \
  --filters "Name=attachment.vpc-id,Values=${VPC_ID}" \
  --query 'InternetGateways[].{Id:InternetGatewayId,State:Attachments[0].State}' \
  --output table