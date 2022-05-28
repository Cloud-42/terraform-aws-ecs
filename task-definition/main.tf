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
      name = volume.value.name

      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)
          dynamic "authorization_config" {
            for_each = lookup(efs_volume_configuration.value, "authorization_config", [])
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }
  tags = var.tags
}
