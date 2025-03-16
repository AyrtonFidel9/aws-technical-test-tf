# Technical Test

## Description
This repository is a Terraform project to host a Solution for Financial Clients. 

**Scenario:** You work for a company that provides a financial decisioning platform to financial institutions (we will call them clients here). Each client has their own configuration and data. To comply with data residency laws and SOC2 requirements, your product has to be deployed in multiple AWS regions. 

#### Table of contents
1. [Diagram](#1-diagram-architecture)
2. [Techonoly Stack](#3-technology-stack)
4. [Directory Structure](#4-directory-structure)
5. [Variables](#5-variables)
6. [Terraform commands](#6-terraform-commands)


### 1. Diagram Architecture

![alt text](image.png)

1. **Internet Gateway**: This component allows internet access for the infrastructure. Allows components to be visible through internet.

2. **Application Load Balancer**: An public applicationload balancer  (layer 7 OSI) is provisioned to recept all request for each customer through internet. Used for PII SANITIZER.

3. **NAT Gateway**: This component allows resources inside private subnets to connect to internet to download patches, libraries or consume external services services.

4. **EC2 Instance (PII Sanitizer)**: Instances to host PII sanitizer services, inside EC2 instance is installed Docker Engine to run containers. They are hosted in private subnets.

5. **EKS Cluster**: This resource is created to implement GATEWAY API services, is deployed using 3 nodes across 3 AVAILABILITY ZONES for realibility. There is an Application Load Balancer (internal type) to expose this microservice through a Service Deployment. Located in a private subnet to protect resources.

6. **Lambdas**: This service is used to host Interface Domain services per client.

7. **VPC GATEWAY ENDPOINT**: This component enhances security and latency for S3 and DynamoDb connection. A VPC Gateway Endpoint setup a private connection between AWS Global Services and services located inside a VPC, using AWS internal network.

8. **DynamoDB**: This service is used for Interface Domain lambdas to store data.

9. **S3 Bucket**:  This component is provisioned to store objects by Lambda's Interface Domain

In terms on Networking, this infrastructure is divided into 5 layers:
- **Public layer (Public Subnets)**: Used to host services that will be exposed through internet and recept requests to redirect them to each compute internal service.

- ****