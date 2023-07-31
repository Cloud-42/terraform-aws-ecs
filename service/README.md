## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.cpu_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.memory_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | The ECS cluster to associate with the service. | `string` | n/a | yes |
| <a name="input_cpu_autoscaling_profile"></a> [cpu\_autoscaling\_profile](#input\_cpu\_autoscaling\_profile) | n/a | `any` | `null` | no |
| <a name="input_cpu_autoscaling_profiles_config"></a> [cpu\_autoscaling\_profiles\_config](#input\_cpu\_autoscaling\_profiles\_config) | n/a | <pre>map(object({<br>    target             = number<br>    max_capacity       = number<br>    min_capacity       = number<br>    scale_in_cooldown  = number<br>    scale_out_cooldown = number<br>  }))</pre> | `null` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Specifies whether to enable Amazon ECS Exec for the tasks within the service. | `bool` | `false` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch Type.  FARGATE or EC2.  Defaults to FARGATE | `string` | `"FARGATE"` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | n/a | <pre>list(object({<br>    container_name   = string<br>    container_port   = number<br>    target_group_arn = string<br>  }))</pre> | `[]` | no |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | The maximum number of tasks supported with autoscaling. | `number` | `1` | no |
| <a name="input_memory_autoscaling_profile"></a> [memory\_autoscaling\_profile](#input\_memory\_autoscaling\_profile) | n/a | `any` | `null` | no |
| <a name="input_memory_autoscaling_profiles_config"></a> [memory\_autoscaling\_profiles\_config](#input\_memory\_autoscaling\_profiles\_config) | n/a | <pre>map(object({<br>    target             = number<br>    max_capacity       = number<br>    min_capacity       = number<br>    scale_in_cooldown  = number<br>    scale_out_cooldown = number<br>  }))</pre> | `null` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | The desired (and minimum for scaling) number of tasks. | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the ECS Service | `string` | n/a | yes |
| <a name="input_network_configurations"></a> [network\_configurations](#input\_network\_configurations) | n/a | <pre>list(object({<br>    subnets          = list(string)<br>    security_groups  = list(string)<br>    assign_public_ip = bool<br>  }))</pre> | `[]` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Whether to propagate the tags from the task definition or the service to the tasks. SERVICE or TASK\_DEFINITION | `string` | `"TASK_DEFINITION"` | no |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | n/a | <pre>list(object({<br>    registry_arn   = optional(string)<br>    port           = optional(number)<br>    container_port = optional(number)<br>    container_name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags map | `map(string)` | `{}` | no |
| <a name="input_task_definition"></a> [task\_definition](#input\_task\_definition) | The name of the ECS Task Definition | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the managed ECS Service. |
| <a name="output_service"></a> [service](#output\_service) | The ECS Service resource created by this module. |
