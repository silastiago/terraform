
resource "aws_instance" "wordpress" {
 ami = var.amis
 key_name = var.key_name
 vpc_security_group_ids = ["${aws_security_group.security_group_instances.id}"]
 source_dest_check = false
 instance_type = "t2.micro"
 tags = {
 Name = "wordpress"
 }
}

