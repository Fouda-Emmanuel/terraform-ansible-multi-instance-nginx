output "instance_public_ips" {
  description = "Instances public IPs"
  value = {for k, v in aws_instance.web : k => v.public_ip}
}

output "instance_dns_names" {
  description = "Instance DNS names"
  value = {for k, v in aws_instance.web : k => v.public_dns}
}