# Create IAM Role
resource "aws_iam_role" "jenkins_s3_role" {
  name = "JenkinsS3UploaderRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Create Permissions/Policy for the IAM Role
resource "aws_iam_policy" "jenkins_s3_policy" {
  name        = "JenkinsS3Policy"
  description = "Allows Jenkins to upload Trivy reports to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectTagging"
        ]
        Resource = [
          "arn:aws:s3:::trivy-reports-${random_string.bucket_suffix.result}/*"
        ]
      }
    ]
  })
}

# Attach the Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "jenkins_s3_attach" {
  role       = aws_iam_role.jenkins_s3_role.name
  policy_arn = aws_iam_policy.jenkins_s3_policy.arn
}

