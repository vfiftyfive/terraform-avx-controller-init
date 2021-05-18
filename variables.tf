variable "aws_profile" { default = "default" }
variable "cft_path" {}
variable "subnet" {}
variable "keyname" {}
variable "vpc_id" {}
variable "new_password" {}
variable "admin_email" {}
variable "region" { default = "us-west-2" }
variable "customer_id" {}
variable "git_url" {}
variable "credentials_file" {}
variable "tf_var_file" {}

locals {
#Get controller private ip address from CFT outputs
  private_ip = {
    for k, v in aws_cloudformation_stack.aviatrix_controller.outputs :
    "address" => v if k == "AviatrixControllerPrivateIP"
  }
  # Get controller public ip address from CFT outputs
  public_ip = {
    for k, v in aws_cloudformation_stack.aviatrix_controller.outputs :
    "address" => v if k == "AviatrixControllerEIP"
  }
}
