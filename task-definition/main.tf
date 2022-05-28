# -------------------------------
# Task definition
# -------------------------------
resource "aws_ecs_task_definition" "service" {
  family                   = var.family
  container_definitions    = var.container_definitions
  requires_compatibilities = var.requires_compatibilities

  cpu          = var.requires_compatibilities == ["FARGATE"] ? var.fargate_cpu : var.cpu
  memory       = var.requires_compatibilities == ["FARGATE"] ? var.fargate_memory : var.memory
  network_mode = var.requires_compatibilities == ["FARGATE"] ? "awsvpc" : var.network_mode

  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn

  dynamic "volume" {
    for_each = var.volumes
    content {

      dynamic "docker_volume_configuration" {
        for_each = var.volumes
        content {
          autoprovision = volume["autoprovision"]
          driver_opts   = volume["driver_opts"]
          driver        = volume["driver"]
          labels        = volume["labels"]
          scope         = volume["scope"]
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = var.volumes
        content {
          file_system_id          = volume["file_system_id"]
          root_directory          = volume["root_directory"]
          transit_encryption      = volume["transit_encryption"]
          transit_encryption_port = volume["transit_encryption_port"]
          dynamic "authorization_config" {
            for_each = var.volumes
            content {
              access_point_id = volume["access_point_id"]
              iam             = volume["iam"]
            }
          }
        }
      }
      host_path = volume["host_path"]
      name      = volume["name"]
    }
  }


  tags = var.tags
}
