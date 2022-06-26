#-----------------------------------------------
# AWS ECS Service
#-----------------------------------------------
resource "aws_ecs_service" "this" {

  cluster       = var.cluster
  name          = var.name
  launch_type   = var.launch_type
  desired_count = var.min_count

  task_definition = var.task_definition

  dynamic "load_balancer" {
    for_each = var.load_balancers
    content {
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
      target_group_arn = load_balancer.value["target_group_arn"]
    }
  }

  dynamic "network_configuration" {
    for_each = var.network_configurations
    content {
      assign_public_ip = network_configuration.value["assign_public_ip"]
      security_groups  = network_configuration.value["security_groups"]
      subnets          = network_configuration.value["subnets"]
    }
  }

  dynamic "service_registries" {
    for_each = var.service_registries
    content {
      registry_arn   = service_registries.value["registry_arn"]
      port           = service_registries.value["port"]
      container_port = service_registries.value["container_port"]
      container_name = service_registries.value["container_name"]
    }
  }

  propagate_tags = var.propagate_tags

  tags = var.tags
}
