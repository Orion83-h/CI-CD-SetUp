# 
output "instance_public_ips" {
  description = "Public IP addresses of the Jenkins, SonarQube, and Minikube instances"
  value = {
  for instance, details in aws_instance.virtual_servers : instance => details.public_ip }
}

#
output "server_ssh_connection" {
  description = "SSH connection commands for each instance"
  value = {
    for instance, details in aws_instance.virtual_servers : instance => "ubuntu@${details.public_ip}"
  }
}

#
output "server_urls" {
  description = "URLs for Jenkins and SonarQube"
  value = {
    jenkins   = "http://${aws_instance.virtual_servers["jenkins"].public_ip}:8081"
    sonarqube = "http://${aws_instance.virtual_servers["sonarqube"].public_ip}:9000"
  }
}
