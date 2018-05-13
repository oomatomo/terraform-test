provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "test"
  }
}

resource "aws_internet_gateway" "test" {
  vpc_id = "${aws_vpc.test.id}"
  tags {
    Name = "test"
  }
}

data "aws_route_table" "test" {
  vpc_id = "${aws_vpc.test.id}"
}

#resource "aws_route_table" "route_table_test" {
#  vpc_id = "${aws_vpc.test.id}"
#  tags {
#      Name = "route_table_test"
#  }
#}

resource "aws_route" "test" {
  route_table_id = "${data.aws_route_table.test.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.test.id}"
}

resource "aws_subnet" "test_a" {
  vpc_id = "${aws_vpc.test.id}"
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = false
  tags {
    Name = "test_a"
  }
}

resource "aws_subnet" "test_c" {
  vpc_id = "${aws_vpc.test.id}"
  availability_zone = "ap-northeast-1c"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  tags {
    Name = "test_c"
  }
}

resource "aws_security_group" "test_bridge" {
  vpc_id = "${aws_vpc.test.id}"
  # if changed, forces new resource.
  name = "test_bridge"
  tags {
    Name = "test_bridge"
  }
}

resource "aws_security_group_rule" "test_bridge_ingress_ssh" {
  security_group_id = "${aws_security_group.test_bridge.id}"
  type = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${var.bridge_ip}/32"]
}

resource "aws_security_group_rule" "test_bridge_egress" {
  security_group_id = "${aws_security_group.test_bridge.id}"
  type = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
