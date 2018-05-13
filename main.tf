provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "vpc_test" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "vpc_test"
  }
}

resource "aws_internet_gateway" "internet_gateway_test" {
  vpc_id = "${aws_vpc.vpc_test.id}"
  tags {
    Name = "internet_gateway_test"
  }
}
