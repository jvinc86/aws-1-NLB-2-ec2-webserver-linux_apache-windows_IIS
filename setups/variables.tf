variable REGION { default = "eu-west-3" }               #OJO si se modifica la region deben adaptarse abajo los AV_ZONES
variable BLOQUE_CIDR_VPC { default = "192.168.0.0/16" } #OJO si se modifica la VPC deben adaptarse abajo los CIDR_SUBRED
variable NOMBRE_PROYECTO { default = "mi_maravilloso_proyecto" }

variable NRO_DE_SUBREDES { default = 3 } #OJO si se modifica este numero, tambien debe modificarse/adaptarse las variables de abajo 
variable AV_ZONES { default = ["eu-west-3a", "eu-west-3b", "eu-west-3c"] }
variable CIDR_PRIVADOS_SUBRED { default = ["192.168.80.0/24", "192.168.81.0/24", "192.168.82.0/24"] }
variable CIDR_PUBLICOS_SUBRED { default = ["192.168.120.0/24", "192.168.121.0/24", "192.168.122.0/24"] }

variable CANTIDAD_INSTANCIAS_LINUX { default = 1 }
variable CANTIDAD_INSTANCIAS_WINDOWS { default = 1 }

variable TIPO_INSTANCIA { default = "t2.micro" }
variable UBUNTU_SERVER_AMI {
  type = map(string)
  default = {
    us-east-1 = "ami-04505e74c0741db8d", # Ubuntu 20.04 (Virginia)
    us-west-1 = "ami-01f87c43e618bf8f0", # Ubuntu 20.04 (California)
    eu-west-3 = "ami-0c6ebbd55ab05f070"  # Ubuntu 20.04 (Paris)
  }
}
variable WIN_SERVER_AMI {
  type = map(string)
  default = {
    us-east-1 = "ami-0d80714a054d3360c", # WindowsServer (Virginia)
    us-west-1 = "ami-0fc6888a6bb1dfba6", # WindowsServer (California)
    eu-west-3 = "ami-05fb43e0cf8358e9a"  # WindowsServer (Paris)
  }
}
# variable CANTIDAD_INSTANCIAS { default = 3 }
variable INSTANCE_USERNAME { default = "vincent" }
variable INSTANCE_PASSWORD { default = "Password!1234" }

variable RUTA_LLAVE_PUBLICA { default = "C:/Users/jvinc/.ssh/id_rsa.pub" }

variable AV_ZONES_WINDOWS {
  type    = list(string)
  default = ["eu-west-3a", "eu-west-3b", "eu-west-3c", "eu-west-3a"]
}
variable AV_ZONES_LINUX {
  type    = list(string)
  default = ["eu-west-3c", "eu-west-3b", "eu-west-3a", "eu-west-3c"]
}

variable TIPO_INSTANCIA_LINUX { default = "t2.micro" }
variable TIPO_INSTANCIA_WINDOWS { default = "t2.medium" }