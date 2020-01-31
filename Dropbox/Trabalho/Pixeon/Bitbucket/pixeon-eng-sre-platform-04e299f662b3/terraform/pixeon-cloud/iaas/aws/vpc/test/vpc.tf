/*
  VPC Definition
*/

resource "aws_vpc" "pixeon_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name          = "${var.stack_name}-${var.stack_env}-vpc"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}


/*
 DHCP Option Set
*/
resource "aws_vpc_dhcp_options" "pixeon_cloud_dhcp" {
  domain_name          = "ec2.internal test.pixeon.cloud"
  domain_name_servers  = ["AmazonProvidedDNS"]
  ntp_servers          = ["192.99.2.8","200.160.7.186"]

  tags {
    Name          = "${var.stack_name}-${var.stack_env}"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}
resource "aws_vpc_dhcp_options_association" "pixeon_cloud_dhcp" {
  vpc_id          = "${aws_vpc.pixeon_vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.pixeon_cloud_dhcp.id}"
}


/*
 Internet Gateway
*/

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  tags {
    Name          = "${var.stack_name}-${var.stack_env}-igw"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }
}

/*
  Public Subnets
*/
resource "aws_subnet" "subnet-A-public" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  cidr_block              = "${var.public_subnet_a_cidr}"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags {
    Name          = "${var.stack_name} ${var.stack_env} public subnet a"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
    Tier          = "public"
  }
}


resource "aws_subnet" "subnet-C-public" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  cidr_block              = "${var.public_subnet_c_cidr}"
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = true

  tags {
    Name          = "${var.stack_name} ${var.stack_env} public subnet c"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
    Tier          = "public"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

// Routes peering connection

// Pixeon Cloud Prod VPC

  route {
    cidr_block     = "${var.pixeon_cloud_prod_network}"
    vpc_peering_connection_id = "${var.pixeon_cloud_prod_peer_id}"

  }


// Pixeon Old VPC
  route {
    cidr_block     = "${var.pixeon_old_network}"
    vpc_peering_connection_id = "${var.pixeon_old_peer_id}"

  }


// Pixeon Orchestration Prod VPC

  route {
    cidr_block     = "${var.orch_prod_network}"
    vpc_peering_connection_id = "${var.orch_prod_peer_id}"

  }

  tags {
    Name          = "${var.stack_name} ${var.stack_env} public route table"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }

}

resource "aws_route_table_association" "associate-public-subnet-A-route-table" {
  subnet_id      = "${aws_subnet.subnet-A-public.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

resource "aws_route_table_association" "associate-public-subnet-C-route-table" {
  subnet_id      = "${aws_subnet.subnet-C-public.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

/*
  Private Subnet
*/

resource "aws_subnet" "subnet-A-private" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  cidr_block        = "${var.private_subnet_a_cidr}"
  availability_zone = "${var.aws_region}a"

  tags {
    Name          = "${var.stack_name} ${var.stack_env} private subnet a"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
    Tier          = "private"
  }
}

resource "aws_subnet" "subnet-C-private" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  cidr_block        = "${var.private_subnet_c_cidr}"
  availability_zone = "${var.aws_region}c"

  tags {
    Name          = "${var.stack_name} ${var.stack_env} private subnet c"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
    Tier          = "private"
  }
}

/*
  Private subnet Route Table
*/

resource "aws_route_table" "private-route-table-A" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw-a.id}"
  }

// Routes peering connection

// Pixeon Cloud Prod VPC

  route {
    cidr_block     = "${var.pixeon_cloud_prod_network}"
    vpc_peering_connection_id = "${var.pixeon_cloud_prod_peer_id}"

  }


// Pixeon Old VPC
  route {
    cidr_block     = "${var.pixeon_old_network}"
    vpc_peering_connection_id = "${var.pixeon_old_peer_id}"

  }


// Pixeon Orchestration Prod VPC

  route {
    cidr_block     = "${var.orch_prod_network}"
    vpc_peering_connection_id = "${var.orch_prod_peer_id}"

  }


  tags {
    Name          = "${var.stack_name} ${var.stack_env} private subnet a"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }

}


resource "aws_route_table" "private-route-table-C" {
  vpc_id = "${aws_vpc.pixeon_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw-a.id}"
  }


// Routes peering connection

// Pixeon Cloud Prod VPC

  route {
    cidr_block     = "${var.pixeon_cloud_prod_network}"
    vpc_peering_connection_id = "${var.pixeon_cloud_prod_peer_id}"

  }


// Pixeon Old VPC
  route {
    cidr_block     = "${var.pixeon_old_network}"
    vpc_peering_connection_id = "${var.pixeon_old_peer_id}"

  }


// Pixeon Orchestration Prod VPC

  route {
    cidr_block     = "${var.orch_prod_network}"
    vpc_peering_connection_id = "${var.orch_prod_peer_id}"

  }

  tags {
    Name          = "${var.stack_name} ${var.stack_env} private subnet c"
    Creation-Tool = "terraform"
    Env           = "${var.stack_env}"
  }

}


//  Private subnet Route Table Association


resource "aws_route_table_association" "associate-private-subnet-A-route-table" {
  subnet_id      = "${aws_subnet.subnet-A-private.id}"
  route_table_id = "${aws_route_table.private-route-table-A.id}"
}

resource "aws_route_table_association" "associate-private-subnet-C-route-table" {
  subnet_id      = "${aws_subnet.subnet-C-private.id}"
  route_table_id = "${aws_route_table.private-route-table-C.id}"
}

/*
  NAT Gateway
*/

resource "aws_nat_gateway" "natgw-a" {
  allocation_id = "${aws_eip.nat-a.id}"
  subnet_id     = "${aws_subnet.subnet-A-public.id}"
}


// NAT Elastic IPS



resource "aws_eip" "nat-a" {
  vpc = true
}


