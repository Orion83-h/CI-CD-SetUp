variable "region" {}

variable "instance_type" {}

variable "aws_az" {}

variable "subnet_id" {}

variable "instance_tag" {}

variable "sec_grp_name" {}

variable "key_name" {}

variable "ingress_rule" {}

variable "vpc_id" {}

variable "volume_size" {}

variable "bucket_tag" {}

# variable "my_ip_address" {}

variable "private_key_path" {
  description = "Path to the private SSH key file"
  type        = string
}