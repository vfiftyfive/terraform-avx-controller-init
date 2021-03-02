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

#Deploy AVTX Controller with CFT
resource "aws_cloudformation_stack" "aviatrix_controller" {
  name = "aviatrix-controller-TF"
  parameters = {
    VPCParam     = data.aws_vpc.selected.id
    SubnetParam  = var.subnet
    KeyNameParam = var.keyname
  }
  template_url = var.cft_path
  capabilities = ["CAPABILITY_NAMED_IAM"]
  on_failure   = "DO_NOTHING"
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "null_resource" "controller_init" {
  triggers = aws_cloudformation_stack.aviatrix_controller.id
  provisioner "local-exec" {
    command = "sleep 180 && scripts/goavxinit"
    environment = {
      PUBLIC_IP    = local.public_ip.address
      PRIVATE_IP   = local.private_ip.address
      ADMIN_EMAIL  = var.admin_email
      NEW_PASSWORD = var.new_password
    }
  }
}