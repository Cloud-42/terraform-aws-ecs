module "efs" {
  source  = "cloudposse/efs/aws"
  version = "0.32.7"

  region  = var.region
  vpc_id  = "vpc-91232e3"
  subnets = ["subnet-66e4812a", "subnet-31234953", "subnet-xyzz717"]

  access_points = {
    "keys" = {
      posix_user = {
        gid            = "1001"
        uid            = "5000"
        secondary_gids = "1002,1003"
      }
      creation_info = {
        gid         = "1001"
        uid         = "5000"
        permissions = "0555"
      }
    }
    "net" = {
      posix_user = {
        gid            = "2001"
        uid            = "6000"
        secondary_gids = null
      }
      creation_info = {
        gid         = "123"
        uid         = "222"
        permissions = "0555"
      }
    }
  }

  additional_security_group_rules = [
    {
      type        = "ingress"
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
      cidr_blocks = ["172.31.0.0/16"]
      description = "Allow ingress traffic to EFS from VPC"
    }
  ]
  security_group_create_before_destroy = false
}

module "core" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.58.1"

  container_name  = "core"
  container_image = "quay.io/core:v2"

  log_configuration = {
    logDriver = var.logDriver
    options = {
      awslogs-region        = var.log_region
      awslogs-group         = "/ecs/core-node"
      awslogs-stream-prefix = var.log_stream_prefix
    }
  }

  port_mappings = [{
    containerPort = "80"
    hostPort      = "80"
    protocol      = "tcp"
  }]

  repository_credentials = {
    credentialsParameter = "arn:aws:secretsmanager:eu-west-1:123456789:secret:quayio-ABCD4wv"
  }

  map_environment = {
    PORT                            = "7770"
    NETWORKCONF_PORT                = "9000"
  }

  mount_points = [{
    containerPath = "/keys/"
    sourceVolume  = "keys"
    readOnly      = true
    },
    {
      containerPath = "/net/"
      sourceVolume  = "net"
      readOnly      = true
  }]
}
module "core-task" {

  source = "git::https://github.com/Cloud-42/terraform-aws-ecs.git//task-definition?ref=v0.4.0"

  container_definitions = module.core.json_map_encoded_list
  family                = "core"
  execution_role_arn    = var.execution_role_arn
  task_role_arn         = module.task_role.role.arn

  fargate_cpu    = "1024"
  fargate_memory = "2048"

  volumes = [{
    name = "keys"
    efs_volume_configuration = [{
      file_system_id          = module.efs.id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 7744
      authorization_config = [{
        access_point_id = module.efs.access_point_ids["keys"]
        iam             = "DISABLED"
      }]
      },
    ]
    docker_volume_configuration = []
    },
    {
      name = "net"
      efs_volume_configuration = [{
        file_system_id          = module.efs.id
        root_directory          = "/"
        transit_encryption      = "ENABLED"
        transit_encryption_port = 7755
        authorization_config = [{
          access_point_id = module.efs.access_point_ids["net"]
          iam             = "DISABLED"
        }]
        },
      ]
      docker_volume_configuration = []
    }
  ]
}
