## Creating Launch Configuration
resource "aws_launch_configuration" "launch" {
  image_id               = var.amis
  instance_type          = "t2.micro"
  security_groups        = [aws_security_group.security_group_elb.id]
  key_name               = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}


### Creating ELB
resource "aws_elb" "elb" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-east-2a", "us-east-2b"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.wordpress.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}  

## Creating AutoScaling Group
resource "aws_autoscaling_group" "autoscaling" {
  launch_configuration = aws_launch_configuration.launch.id
  availability_zones = ["us-east-2a", "us-east-2b"]
  min_size = 2
  max_size = 10
  load_balancers = ["${aws_elb.elb.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "aws_autoscaling_policy_up" {
  name                   = "aws_autoscaling_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy_down" {
  name                   = "aws_autoscaling_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
}