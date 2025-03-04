resource "aws_instance" "roboshop_ec2" {
  for_each = var.instances #each.key and each.value
  ami           = data.aws_ami.ami_info.id
  instance_type = each.value
  vpc_security_group_ids = [var.allow_all]
  tags = {
    Name = each.key
  }
}

resource "aws_route53_record" "roboshop_r53" {
  for_each = aws_instance.roboshop_ec2
  zone_id = var.zone_id
  name    = each.key == "web" ? var.domain_name : "${each.key}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = each.key == "web" ? [each.value.public_ip] : [each.value.private_ip]
  allow_overwrite = true
}

#This instance is used for ansible project only
resource "aws_instance" "ansible_master" {
    ami           = data.aws_ami.ami_info.id
    instance_type = var.ansible_master.instance_type
    vpc_security_group_ids = [var.allow_all]
    user_data = file("${path.module}/ansible_install.sh")
    tags = {
        Name = "ansible-master"
    }
}

#This r53 is used for ansible project only
resource "aws_route53_record" "ansible_r53" {
    zone_id = var.zone_id
    name    = "ansible.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.ansible_master.public_ip]
    allow_overwrite = true
}