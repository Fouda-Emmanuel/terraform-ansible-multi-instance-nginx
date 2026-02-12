variable "instance_type" {
  description = "EC2 instance type"
  default = "t3.micro"
}

variable "aws_region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "instance_names" {
  description = "List of Instances"
  type = list(string)
  default = ["web01", "web02"]
}

variable "ami_id" {
  description = "AMI ID"
  default = "ami-0b6c6ebed2801a5cb"
}