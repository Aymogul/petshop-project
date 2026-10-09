output "certificate_arn" {
  description = "Certificate ARN issued through ACM and validated in Route53."
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "app_record_fqdn" {
  description = "FQDN of the public application DNS record."
  value       = aws_route53_record.app.fqdn
}
