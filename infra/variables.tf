variable "aws_region" {
  description = "AWS region used to deploy CloudShip"
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR block used by the CloudShip VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "project_name" {
  description = "Name used to identify CloudShip resources"
  type        = string
  default     = "cloudship"
}
variable "admin_cidr" {
  description = "Public IP allowed to access Jenkins and SSH"
  type        = string
}
variable "ssh_public_key_path" {
  description = "Path to the SSH public key used by CloudShip EC2 instances"
  type        = string
}
variable "jenkins_instance_type" {
  description = "EC2 instance type used for the Jenkins server"
  type        = string
  default     = "t3.small"
}

variable "app_instance_type" {
  description = "EC2 instance type used for the application server"
  type        = string
  default     = "t3.micro"
}