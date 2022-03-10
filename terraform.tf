terraform {
  required_providers {
    aws =  {
    source = "hashicorp/aws"
    version = ">= 2.7.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "terraform_backend_bucket" {
      bucket = "terraform-state-6brvs20xri41vv9kz4y41ppx8tkszm6ndsju7nmr35ank"
}

resource "aws_instance" "vminstance" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.medium"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.vminstance_iam_role_instance_profile.name
}

resource "aws_eip" "vminstance_eip" {
      instance = aws_instance.vminstance.id
      vpc = true
}

resource "aws_iam_user" "vminstance_iam" {
      name = "vminstance_iam"
}

resource "aws_iam_user_policy_attachment" "vminstance_iam_policy_attachment0" {
      user = aws_iam_user.vminstance_iam.name
      policy_arn = aws_iam_policy.vminstance_iam_policy0.arn
}

resource "aws_iam_policy" "vminstance_iam_policy0" {
      name = "vminstance_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.vminstance_iam_policy_document.json
}

resource "aws_iam_access_key" "vminstance_iam_access_key" {
      user = aws_iam_user.vminstance_iam.name
}

resource "aws_instance" "testinstancethree" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.medium"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.testinstancethree_iam_role_instance_profile.name
}

resource "aws_eip" "testinstancethree_eip" {
      instance = aws_instance.testinstancethree.id
      vpc = true
}

resource "aws_s3_bucket" "testinstance" {
      bucket = "testinstance"
}

resource "aws_s3_bucket_public_access_block" "testinstance_access" {
      bucket = aws_s3_bucket.testinstance.id
      block_public_acls = true
      block_public_policy = true
}

resource "aws_iam_user" "testinstance_iam" {
      name = "testinstance_iam"
}

resource "aws_iam_user_policy_attachment" "testinstance_iam_policy_attachment0" {
      user = aws_iam_user.testinstance_iam.name
      policy_arn = aws_iam_policy.testinstance_iam_policy0.arn
}

resource "aws_iam_policy" "testinstance_iam_policy0" {
      name = "testinstance_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.testinstance_iam_policy_document.json
}

resource "aws_iam_access_key" "testinstance_iam_access_key" {
      user = aws_iam_user.testinstance_iam.name
}

resource "aws_dynamodb_table" "testdb" {
      name = "testdb"
      hash_key = "userID"
      billing_mode = "PAY_PER_REQUEST"
      ttl {
        attribute_name = "TimeToExist"
        enabled = true
      }
      attribute {
        name = "userID"
        type = "S"
      }
}

resource "aws_iam_user" "testdb_iam" {
      name = "testdb_iam"
}

resource "aws_iam_user_policy_attachment" "testdb_iam_policy_attachment0" {
      user = aws_iam_user.testdb_iam.name
      policy_arn = aws_iam_policy.testdb_iam_policy0.arn
}

resource "aws_iam_policy" "testdb_iam_policy0" {
      name = "testdb_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.testdb_iam_policy_document.json
}

resource "aws_iam_access_key" "testdb_iam_access_key" {
      user = aws_iam_user.testdb_iam.name
}

resource "aws_iam_instance_profile" "vminstance_iam_role_instance_profile" {
      name = "vminstance_iam_role_instance_profile"
      role = aws_iam_role.vminstance_iam_role.name
}

resource "aws_iam_instance_profile" "testinstancethree_iam_role_instance_profile" {
      name = "testinstancethree_iam_role_instance_profile"
      role = aws_iam_role.testinstancethree_iam_role.name
}

resource "aws_iam_role" "vminstance_iam_role" {
      name = "vminstance_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role" "testinstancethree_iam_role" {
      name = "testinstancethree_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role_policy_attachment" "vminstance_iam_role_testinstance_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.testinstance_iam_policy0.arn
      role = aws_iam_role.vminstance_iam_role.name
}

resource "aws_iam_role_policy_attachment" "testinstancethree_iam_role_testinstance_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.testinstance_iam_policy0.arn
      role = aws_iam_role.testinstancethree_iam_role.name
}

resource "aws_iam_role_policy_attachment" "vminstance_iam_role_testdb_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.testdb_iam_policy0.arn
      role = aws_iam_role.vminstance_iam_role.name
}

resource "aws_iam_role_policy_attachment" "testinstancethree_iam_role_testdb_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.testdb_iam_policy0.arn
      role = aws_iam_role.testinstancethree_iam_role.name
}

resource "aws_subnet" "devxp_vpc_subnet_public0" {
      vpc_id = aws_vpc.devxp_vpc.id
      cidr_block = "10.0.0.0/25"
      map_public_ip_on_launch = true
      availability_zone = "us-west-2a"
}

resource "aws_subnet" "devxp_vpc_subnet_public1" {
      vpc_id = aws_vpc.devxp_vpc.id
      cidr_block = "10.0.128.0/25"
      map_public_ip_on_launch = true
      availability_zone = "us-west-2b"
}

resource "aws_internet_gateway" "devxp_vpc_internetgateway" {
      vpc_id = aws_vpc.devxp_vpc.id
}

resource "aws_route_table" "devxp_vpc_routetable_pub" {
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devxp_vpc_internetgateway.id
      }
      vpc_id = aws_vpc.devxp_vpc.id
}

resource "aws_route" "devxp_vpc_internet_route" {
      route_table_id = aws_route_table.devxp_vpc_routetable_pub.id
      destination_cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.devxp_vpc_internetgateway.id
}

resource "aws_route_table_association" "devxp_vpc_subnet_public_assoc" {
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      route_table_id = aws_route_table.devxp_vpc_routetable_pub.id
}

resource "aws_vpc" "devxp_vpc" {
      cidr_block = "10.0.0.0/16"
      enable_dns_support = true
      enable_dns_hostnames = true
}

resource "aws_security_group" "devxp_security_group" {
      vpc_id = aws_vpc.devxp_vpc.id
      name = "devxp_security_group"
      ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

data "aws_iam_policy_document" "vminstance_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.vminstance.arn]
      }
}

data "aws_ami" "ubuntu_latest" {
      most_recent = true
      owners = ["099720109477"]
      filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64*"]
      }
      filter {
        name = "virtualization-type"
        values = ["hvm"]
      }
}

data "aws_iam_policy_document" "testinstance_iam_policy_document" {
      statement {
        actions = ["s3:ListAllMyBuckets"]
        effect = "Allow"
        resources = ["arn:aws:s3:::*"]
      }
      statement {
        actions = ["s3:*"]
        effect = "Allow"
        resources = [aws_s3_bucket.testinstance.arn]
      }
}

data "aws_iam_policy_document" "testdb_iam_policy_document" {
      statement {
        actions = ["dynamodb:DescribeTable", "dynamodb:Query", "dynamodb:Scan", "dynamodb:BatchGet*", "dynamodb:DescribeStream", "dynamodb:DescribeTable", "dynamodb:Get*", "dynamodb:Query", "dynamodb:Scan", "dynamodb:BatchWrite*", "dynamodb:CreateTable", "dynamodb:Delete*", "dynamodb:Update*", "dynamodb:PutItem"]
        effect = "Allow"
        resources = [aws_dynamodb_table.testdb.arn]
      }
      statement {
        actions = ["dynamodb:List*", "dynamodb:DescribeReservedCapacity*", "dynamodb:DescribeLimits", "dynamodb:DescribeTimeToLive"]
        effect = "Allow"
        resources = ["*"]
      }
}

