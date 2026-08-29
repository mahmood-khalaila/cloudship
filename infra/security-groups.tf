# Security Group for the Application Load Balancer
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Controls traffic for the Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}


# Allow HTTP traffic from the internet to the ALB
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}


# Allow the ALB to send traffic to the application
resource "aws_vpc_security_group_egress_rule" "alb_to_app" {
  security_group_id = aws_security_group.alb.id

  referenced_security_group_id = aws_security_group.app.id
  from_port                    = 8000
  to_port                      = 8000
  ip_protocol                  = "tcp"
}


# Security Group for the Jenkins EC2 instance
resource "aws_security_group" "jenkins" {
  name        = "${var.project_name}-jenkins-sg"
  description = "Controls access to the Jenkins server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-jenkins-sg"
  }
}


# Allow SSH to Jenkins only from the administrator IP
resource "aws_vpc_security_group_ingress_rule" "jenkins_ssh" {
  security_group_id = aws_security_group.jenkins.id

  cidr_ipv4   = var.admin_cidr
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}


# Allow access to the Jenkins web interface from the administrator IP
resource "aws_vpc_security_group_ingress_rule" "jenkins_web" {
  security_group_id = aws_security_group.jenkins.id

  cidr_ipv4   = var.admin_cidr
  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"
}


# Allow Jenkins to access the internet
resource "aws_vpc_security_group_egress_rule" "jenkins_outbound" {
  security_group_id = aws_security_group.jenkins.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


# Security Group for the application EC2 instance
resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Controls access to the application server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-app-sg"
  }
}


# Allow application traffic only from the ALB
resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id = aws_security_group.app.id

  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 8000
  to_port                      = 8000
  ip_protocol                  = "tcp"
}


# Allow SSH to the application server only from Jenkins
resource "aws_vpc_security_group_ingress_rule" "app_ssh_from_jenkins" {
  security_group_id = aws_security_group.app.id

  referenced_security_group_id = aws_security_group.jenkins.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
}


# Allow the application server to access the internet
resource "aws_vpc_security_group_egress_rule" "app_outbound" {
  security_group_id = aws_security_group.app.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}