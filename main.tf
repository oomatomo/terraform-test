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

data "aws_route_table" "route_table_test" {
  vpc_id = "${aws_vpc.vpc_test.id}"
}

#resource "aws_route_table" "route_table_test" {
#  vpc_id = "${aws_vpc.vpc_test.id}"
#  tags {
#      Name = "route_table_test"
#  }
#}

resource "aws_route" "route_test" {
  route_table_id = "${data.aws_route_table.route_table_test.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.internet_gateway_test.id}"
}
