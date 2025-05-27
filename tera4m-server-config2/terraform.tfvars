region = "us-east-1"

instance_type = "t3.medium"

aws_az = "us-east-1a"

subnet_id = "subnet-079faa6ac6ca4cafd"

instance_tag = "Jenkins_Server"

sec_grp_name = "Jenkins-SG"

key_name = "clusterKey"

ingress_rule = [22, 80, 8080, 8081, 9000, 50000]

vpc_id = "vpc-031c58f78e543401f"

volume_size = 30

bucket_tag = "jenkins-terraform-bucket"

private_key_path = "C:/path/to/key/file"

# my_ip_address = ["154.72.167.34/32"] // [curl ifconfig.me] command to get your ip addr from your computer.