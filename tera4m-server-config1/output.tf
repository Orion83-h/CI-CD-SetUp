# 
output "instance_public_ips" {
  description = "Public IP addresses of the Jenkins, Nexus, and Minikube instances"
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
    Jenkins = "http://${aws_instance.virtual_servers["Jenkins"].public_ip}:8082"
    Nexus   = "http://${aws_instance.virtual_servers["Nexus"].public_ip}:8081"
  }
}

# Get S3 bucket name
output "bucket_name" {
  value = aws_s3_bucket.trivy_reports_bucket.bucket
}
