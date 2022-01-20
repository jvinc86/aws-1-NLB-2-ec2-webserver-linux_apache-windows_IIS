REGION          = "eu-west-3"
BLOQUE_CIDR_VPC = "10.0.0.0/16"
NOMBRE_PROYECTO = "entelApp"

NRO_DE_SUBREDES  = 1
AV_ZONES_WINDOWS = ["eu-west-3a", "eu-west-3b", "eu-west-3c", "eu-west-3a"]
AV_ZONES_LINUX   = ["eu-west-3a", "eu-west-3b", "eu-west-3c", "eu-west-3a"]

CIDR_PRIVADOS_SUBRED = ["10.0.20.0/24", "10.0.30.0/24", "10.0.40.0/24", "10.0.50.0/24"]
# CIDR_PUBLICOS_SUBRED = ["10.0.100.0/24", "10.0.150.0/24", "10.0.200.0/24", "10.0.250.0/24"]

CANTIDAD_INSTANCIAS_LINUX   = 1
CANTIDAD_INSTANCIAS_WINDOWS = 1
TIPO_INSTANCIA_LINUX        = "t2.small"
TIPO_INSTANCIA_WINDOWS      = "t2.medium"
INSTANCE_USERNAME           = "vincent"
INSTANCE_PASSWORD           = "Password!1234"

UBUNTU_SERVER_AMI = {
  us-east-1 = "ami-04505e74c0741db8d", # Ubuntu 20.04 (Virginia)
  us-west-1 = "ami-01f87c43e618bf8f0", # Ubuntu 20.04 (California)
  eu-west-3 = "ami-0c6ebbd55ab05f070"  # Ubuntu 20.04 (Paris)
}
WIN_SERVER_AMI = {
  us-east-1 = "ami-0d80714a054d3360c", # WindowsServer2019 (Virginia)
  us-west-1 = "ami-0fc6888a6bb1dfba6", # WindowsServer2019 (California)
  eu-west-3 = "ami-05fb43e0cf8358e9a"  # WindowsServer2019 (Paris)
}

RUTA_LLAVE_PUBLICA = "C:/Users/jvinc/.ssh/id_rsa.pub"