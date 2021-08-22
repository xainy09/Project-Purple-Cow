
 resource "aws_iam_role_policy" "dev_policy" {
  name = "dev_policy"
  role = aws_iam_role.dev_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = "${file("./dev_policy.json")}"
}

resource "aws_iam_role" "dev_role" {
  name = "dev_role"

  assume_role_policy = "${file("./dev_assume_role_policy.json")}"
}

resource "aws_lambda_function" "dev_lamda" {
  filename      = "output/checkSSlCert.zip"
  function_name = "checkSSlCert"
  role          = aws_iam_role.dev_role.arn
  handler       = "$checkSSlCert.Get_SSlCert"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  #source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = ".NET Core 3.1"

}

data "archive_file" "dev" {
  type        = "zip"
  source_file = "checkSSlCert"
  output_path = "output/checkSSlCert.zip"
}