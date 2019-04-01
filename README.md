Terraform module for Basic VPC setup on AWS infrastructure

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enable\_dns\_hostnames | should be true if you want to use private DNS within the VPC | string | `"true"` | no |
| enable\_dns\_support | should be true if you want to use private DNS within the VPC | string | `"true"` | no |
| map\_public\_ip\_on\_launch | should be false if you do not want to auto-assign public IP on launch | string | `"false"` | no |
| name | Name tag | string | n/a | yes |
| private\_subnets | A list of private subnets inside the VPC. | list | n/a | yes |
| public\_subnets | A list of public subnets inside the VPC. | list | n/a | yes |
| tags | A map of tags to add to all resources | map | n/a | yes |
| vpc\_cidr | (Required) The CIDR block for the VPC | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_route\_table\_ids |  |
| private\_subnets\_ids |  |
| vpc\_cidr\_block |  |
| vpc\_id | TF output resources |
