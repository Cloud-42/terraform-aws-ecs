module "my_ecs_service_fargate" {
  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/terraform-aws-ecs-service?ref=0.2.0"

  name             = "MyServiceName"
  cluster          = "MyClusterName"
  task_definition  = "MyTaskDefinitionName"
  min_count        = 2
  target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567797:targetgroup/ecs-UAT/c63b4fef71808c72"
  load_balancers = [{
    container_name   = "${var.env}-${var.name}"
    container_port   = var.containerPort
    target_group_arn = aws_alb_target_group.ecs_service.arn
  }]
  network_configurations = [{
    subnets          = data.terraform_remote_state.core.outputs.private_subnets
    security_groups  = ["MySecurityGroupNameX", "MySecurityGroupNameY"]
    assign_public_ip = false
  }]
  enable_execute_command = true
}

module "my_ecs_service_ec2" {
  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/terraform-aws-ecs-service?ref=0.2.0"

  name             = "MyServiceName"
  cluster          = "MyClusterName"
  task_definition  = "MyTaskDefinitionName"
  min_count        = 2
  launch_type      = "EC2"
  target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567797:targetgroup/ecs-UAT/c63b4fef71808c72"
  load_balancers = [{
    container_name   = "${var.env}-${var.name}"
    container_port   = var.containerPort
    target_group_arn = aws_alb_target_group.ecs_service.arn
  }]
}
