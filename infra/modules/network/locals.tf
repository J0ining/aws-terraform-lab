locals {
  public_subnet_ids  = [for subnet in aws_subnet.main : subnet.id if subnet.tags.Type == "public"]
  private_subnet_ids = [for subnet in aws_subnet.main : subnet.id if subnet.tags.Type == "private"]
}
