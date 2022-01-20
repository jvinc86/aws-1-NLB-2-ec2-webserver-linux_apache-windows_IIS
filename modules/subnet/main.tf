resource "aws_subnet" "mi_subred" {
  count                   = var.cantidad_subredes
  vpc_id                  = var.el_id_de_la_VPC
  availability_zone       = var.los_az[count.index]
  cidr_block              = var.rangos_cidr_subredes[count.index]
  map_public_ip_on_launch = var.asigna_ip_publica
  tags                    = { Name = "subnet-${var.tipo_subred}-${count.index+1}-${var.proyecto}" }
}

locals {
  reglas_ingress = [
    { puerto = 3389
      resumen = "Puerto RDP" },
    { puerto = 22
      resumen = "Puerto SSH" },
    { puerto = 80
      resumen = "Puerto HTTP" },
    { puerto = 8080
      resumen = "Puerto Web 2" },
    { puerto = 443
      resumen = "Puerto HTTPS" }
  ]
}

resource "aws_security_group" "mi_sec_group" {
  name   = "${var.proyecto}-sg-${var.tipo_subred}"
  vpc_id = var.el_id_de_la_VPC

  dynamic "ingress" {
    for_each = local.reglas_ingress

    content {
      description = ingress.value.resumen
      from_port   = ingress.value.puerto
      to_port     = ingress.value.puerto
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    description      = "Permitir PING"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-${var.tipo_subred}-${var.proyecto}" }

}

resource "aws_network_acl" "mi_network_acl" {
  vpc_id     = var.el_id_de_la_VPC
  subnet_ids = var.los_IDs_subredes

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = { Name = "acl-${var.tipo_subred}-${var.proyecto}" }
}