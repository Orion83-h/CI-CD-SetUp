# Deploying 3 EC2 instances for different purposes
resource "aws_instance" "virtual_servers" {
  for_each          = var.instances
  ami               = data.aws_ami.ami-data.id
  instance_type     = each.value.instance_type
  security_groups   = [aws_security_group.demo.id]
  subnet_id         = var.subnet_id
  availability_zone = var.aws_az
  key_name          = var.key_name

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name    = each.value.name_tag
    Purpose = each.key # Adds Jenkins, SonarQube, or Minikube as a purpose
  }

  # Provisioner to configure each instance
  provisioner "remote-exec" {
    when   = create
    inline = var.provisioning_scripts[each.key]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}
