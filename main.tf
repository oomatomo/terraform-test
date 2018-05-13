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
