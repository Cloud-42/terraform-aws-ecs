## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.4 |
| aws | >= 3.28.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.28.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster | The ECS cluster to associate with the service. | `string` | n/a | yes |
| launch\_type | Launch Type.  FARGATE or EC2.  Defaults to FARGATE | `string` | `"FARGATE"` | no |
| load\_balancers | n/a | <pre>list(object({<br>    container\_name   = string<br>    container\_port   = number<br>    target\_group\_arn = string<br>  }))</pre> | `[]` | no |
| max\_count | The maximum number of tasks supported with autoscaling. | `number` | `1` | no |
| min\_count | The desired (and minimum for scaling) number of tasks. | `number` | `1` | no |
| name | The name of the ECS Service | `string` | n/a | yes |
| network\_configurations | n/a | <pre>list(object({<br>    subnets       = list(string)<br>    security\_groups  = list(string)<br>    assign\_public\_ip = bool<br>  }))</pre> | `[]` | no |
| propagate\_tags | Whether to propagate the tags from the task definition or the service to the tasks. SERVICE or TASK\_DEFINITION | `string` | `"TASK_DEFINITION"` | no |
| tags | Tags map | `map(string)` | `{}` | no |
| target\_tracking\_scaling\_policies | n/a | <pre>list(object({<br>    metric             = string<br>    target_value       = number<br>    scale\_in\_cooldown  = number<br>    scale\_out\_cooldown = number<br>  }))</pre> | `[]` | no |
| task\_definition | The name of the ECS Task Definition | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the managed ECS Service. |
| service | The ECS Service resource created by this module. |
