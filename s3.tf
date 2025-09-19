resource "aws_s3_bucket" "serverus_bucket" {
  bucket = local.s3_suffix
}
