## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.8 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | A list of valid container definitions provided as a single valid JSON document | `any` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU to assign to the task when launch type is EC2 | `any` | `null` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ARN of the IAM role for the task to use | `any` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | Task name, must be unique | `string` | n/a | yes |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | CPU to assign to Fargate task when launch type is FARGATE | `string` | `"512"` | no |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | Memory to assign when launch type is FARGATE | `string` | `"1024"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory to assign when launch type is EC2 | `any` | `null` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Network mode. The valid values are none, bridge, awsvpc, and host. | `string` | `null` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | Launch type. EC2 or FARGATE. | `list` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags map | `map(string)` | `{}` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ARN of the IAM role for the task to use | `any` | n/a | yes |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | (Optional) A set of volume blocks that containers in your task may use | <pre>list(object({<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver_opts   = map(string)<br>      driver        = string<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = number<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_family"></a> [family](#output\_family) | n/a |
| <a name="output_revision"></a> [revision](#output\_revision) | n/a |
| <a name="output_task_definition"></a> [task\_definition](#output\_task\_definition) | n/a |

