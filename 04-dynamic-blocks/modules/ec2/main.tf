# -----------------------------------------------------------------------------
# EC2 Module with Dynamic EBS Blocks
# Demonstrates dynamic blocks and conditional expressions
# -----------------------------------------------------------------------------

resource "aws_instance" "server" {
  ami                         = "ami-0528a5175983e7f28"
  instance_type               = "t2.micro"
  associate_public_ip_address = var.associate_public_ip_address

  # Dynamic block with for_each loop for additional EBS volumes
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device

    content {
      device_name           = ebs_block_device.value.device_name
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  tags = {
    Name = var.servername
  }
}

# -----------------------------------------------------------------------------
# Elastic IP (Conditional)
# Only created when associate_public_ip_address is true
# -----------------------------------------------------------------------------

resource "aws_eip" "pip" {
  count = var.associate_public_ip_address ? 1 : 0

  instance = aws_instance.server.id
  domain   = "vpc"

  tags = {
    Name = "${var.servername}-eip"
  }
}

