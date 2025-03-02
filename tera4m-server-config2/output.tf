# Get Instance Public IP
output "instance_public_ip" {
  value = aws_instance.virtual_server.public_ip
}

# Get Jenkins url
output "jenkins_url" {
  value = "http://${aws_instance.virtual_server.public_ip}:8081"
}

output "ssh-access" {
  value = aws_instance.virtual_server.public_ip != "" ? "ubuntu@${aws_instance.virtual_server.public_ip}" : "No public IP assigned to this instance."
}

output "bucket_name" {
  value = aws_s3_bucket.trivy_reports.bucket
}
