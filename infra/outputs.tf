output "jenkins_public_ip" {
  description = "Public IP address of the Jenkins server"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_url" {
  description = "URL used to access the Jenkins web interface"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "app_public_ip" {
  description = "Public IP address of the application server"
  value       = aws_instance.app.public_ip
}

output "load_balancer_dns" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "application_url" {
  description = "Public URL of the CloudShip application"
  value       = "http://${aws_lb.app.dns_name}"
}