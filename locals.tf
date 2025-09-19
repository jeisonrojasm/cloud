locals {
  suffix = "${var.tags.project}-${var.tags.env}-${var.tags.region}"
}

resource "random_string" "s3_suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  s3_suffix = "${var.tags.project}-${random_string.s3_suffix.result}"
}
