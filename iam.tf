# IAM role for flow log
resource "aws_iam_role" "vpc_flow_log_role" {
  name = "${var.name}_vpc_flow_log_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "vpc-flow-logs.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
   ]
}
EOF
}

# IAM policy for flow log
resource "aws_iam_role_policy" "vpc_flow_log_policy" {
  name = "${var.name}_vpc_flow_log_policy"
  role = "${aws_iam_role.vpc_flow_log_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
       "Action": [
           "logs:CreateLogGroup",
           "logs:CreateLogStream",
           "logs:PutLogEvents",
           "logs:DescribeLogGroups",
           "logs:DescribeLogStreams"
         ],
         "Effect": "Allow",
         "Resource": "*"
      }
  ]
}
EOF
}
