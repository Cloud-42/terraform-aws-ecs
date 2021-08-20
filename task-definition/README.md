## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.4 |
| aws | >= 3.25 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.25 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| container\_definitions | A list of valid container definitions provided as a single valid JSON document | `any` | n/a | yes |
| cpu | CPU to assign to the task when launch type is EC2 | `any` | `null` | no |
| execution\_role\_arn | ARN of the IAM role for the task to use | `any` | n/a | yes |
| family | Task name, must be unique | `string` | n/a | yes |
| fargate\_cpu | CPU to assign to Fargate task when launch type is FARGATE | `string` | `"512"` | no |
| fargate\_memory | Memory to assign when launch type is FARGATE | `string` | `"1024"` | no |
| memory | Memory to assign when launch type is EC2 | `any` | `null` | no |
| network\_mode | Network mode. The valid values are none, bridge, awsvpc, and host. | `string` | `null` | no |
| requires\_compatibilities | Launch type. EC2 or FARGATE. | `list` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| tags | Tags map | `map(string)` | `{}` | no |
| task\_role\_arn | ARN of the IAM role for the task to use | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| family | n/a |
| revision | n/a |
| task\_definition | n/a |
