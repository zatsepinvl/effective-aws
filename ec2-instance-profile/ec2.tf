resource "aws_instance" "ec2" {
  ami                  = "ami-03a6eaae9938c858c" // Amazon Linux 2023 AMI 64-bit (x86)
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2.name
}

resource "aws_iam_instance_profile" "ec2" {
  name = "ec2-ssm"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role" "ec2" {
  name               = "ec2-ssm"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}