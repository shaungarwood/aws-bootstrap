###############################
# Create a Managed IAM Policy #
###############################
resource "aws_iam_policy" "power_dev" {
  name        = "power-dev-policy"
  description = "Giving developers everything they need"

  policy = data.aws_iam_policy_document.power_dev.json
}


#########################################
# Create an IAM Group and attach policy #
#########################################
resource "aws_iam_group" "power_dev" {
  name = "PowerDev"
}

resource "aws_iam_group_policy_attachment" "attach_bootstrap_policy" {
  group      = aws_iam_group.power_dev.name
  policy_arn = aws_iam_policy.power_dev.arn
}


######################################
# Create the IAM User and Membership #
######################################
resource "aws_iam_user" "dev" {
  name = var.iam_user_name
  path = "/"
}

resource "aws_iam_user_group_membership" "dev_membership" {
  user   = aws_iam_user.dev.name
  groups = [aws_iam_group.power_dev.name]
}


#########################
# Create an Access Key  #
#########################
resource "aws_iam_access_key" "dev_access_key" {
  user = aws_iam_user.dev.name
}


###################
# Output the Keys #
###################
output "dev_access_key_id" {
  value       = aws_iam_access_key.dev_access_key.id
  description = "The access key ID for the dev user."
}

output "dev_secret_access_key" {
  value       = aws_iam_access_key.dev_access_key.secret
  description = "The secret access key for the dev user."
  sensitive   = true
}


#####################################
# Create a local file with the keys #
#####################################
resource "local_file" "aws_credentials" {
  content  = <<EOF
User Name,Access Key Id,Secret Access Key
${aws_iam_user.dev.name},${aws_iam_access_key.dev_access_key.id},${aws_iam_access_key.dev_access_key.secret}
EOF
  filename = "${path.module}/aws_credentials.csv"
  file_permission = "0400"
}
