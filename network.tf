# Virtuelle Private Cloud
resource "aws_vpc" "todo_vpc" {
  cidr_block = "172.16.0.0/16"
}

# Gateway ins Internet
resource "aws_internet_gateway" "todo_gw" {
  vpc_id = aws_vpc.todo_vpc.id
}

# Routing Tabelle 
resource "aws_route_table" "todo_route_table" {
  vpc_id = aws_vpc.todo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.todo_gw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.todo_gw.id
  }
}

# Eigenes subnetz
resource "aws_subnet" "todo_subnet" {
  vpc_id            = aws_vpc.todo_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"
}

#Zuweisen von subnet mit Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.todo_subnet.id
  route_table_id = aws_route_table.todo_route_table.id
}

# Estellen von Netzwerkinterface
resource "aws_network_interface" "todo_interface" {
  subnet_id       = aws_subnet.todo_subnet.id
  private_ips     = ["172.16.10.100"]
  security_groups = [aws_security_group.allow_web.id]
}

# Elastic IP erstellen und dem Networkinterface hinzufügen
resource "aws_eip" "todo_ip" {
  vpc                       = true
  network_interface         = aws_network_interface.todo_interface.id
  associate_with_private_ip = "172.16.10.100"
  depends_on                = [aws_internet_gateway.todo_gw]
}
