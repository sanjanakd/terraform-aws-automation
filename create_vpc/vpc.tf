resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name =  "test-vpc"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

/*
Setup public Subnets
*/

resource "aws_subnet" "zone-a" {
  cidr_block = "${var.subnet_cidr_a}"
  vpc_id = "${aws_vpc.default.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags {
    Name = "public_subnet_A"
  }
}

resource "aws_subnet" "zone-b" {
  cidr_block = "${var.subnet_cidr_b}"
  vpc_id = "${aws_vpc.default.id}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  tags {
    Name = "public_subnet_B"
  }
}

//public Subnet route rules

resource "aws_route_table" "zone-a" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"

  }

  tags {
    Name = "route_subnet_A"
  }
}

resource "aws_route_table_association" "zone-a" {
  route_table_id = "${aws_route_table.zone-a.id}"
  subnet_id = "${aws_subnet.zone-a.id}"
}

resource "aws_route_table" "zone-b" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "route_subnet_B"
  }
}

resource "aws_route_table_association" "zone-b" {
  route_table_id = "${aws_route_table.zone-b.id}"
  subnet_id = "${aws_subnet.zone-b.id}"
}
