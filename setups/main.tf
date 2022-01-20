#---------- Subnet, Security Group y Network_ACL  -------------------
module "subredes_privadas" {
  source               = "../modules/subnet"
  el_id_de_la_VPC      = aws_vpc.mi_red.id
  proyecto             = var.NOMBRE_PROYECTO
  los_az               = var.AV_ZONES
  cantidad_subredes    = var.NRO_DE_SUBREDES
  tipo_subred          = "privada"
  rangos_cidr_subredes = var.CIDR_PRIVADOS_SUBRED
  asigna_ip_publica    = true
  los_IDs_subredes     = module.subredes_privadas.IDs_subredes_Forma_1
}

#---------- Instancia EC2 Ubuntu 20.04  -----------------------------
module "vm_linux_privada" {
  source               = "../modules/ec2_linux"
  el_id_de_la_VPC      = aws_vpc.mi_red.id
  proyecto             = var.NOMBRE_PROYECTO
  cantidad_instancias  = var.CANTIDAD_INSTANCIAS_LINUX
  tipo_subred          = "privada"
  los_IDs_subredes     = module.subredes_privadas.IDs_subredes_Forma_1
  ID_Sec_Group         = module.subredes_privadas.SG_id
  ubicacion_public_key = var.RUTA_LLAVE_PUBLICA
  la_aplicacion_1      = "Pagos"
  la_aplicacion_2      = "Compras"
  AZs                  = var.AV_ZONES_LINUX
  win_server_ami       = var.UBUNTU_SERVER_AMI
  region               = var.REGION
  tipo_instancia       = var.TIPO_INSTANCIA_LINUX
  win_o_linux          = "linux"
  instance_username    = var.INSTANCE_USERNAME
  instance_password    = var.INSTANCE_PASSWORD
}

#---------- Instancia EC2 Windows Server 2019 -------------------------
module "vm_windows_privada" {
  source               = "../modules/ec2_windows"
  el_id_de_la_VPC      = aws_vpc.mi_red.id
  proyecto             = var.NOMBRE_PROYECTO
  cantidad_instancias  = var.CANTIDAD_INSTANCIAS_WINDOWS
  tipo_subred          = "privada"
  los_IDs_subredes     = module.subredes_privadas.IDs_subredes_Forma_1
  ID_Sec_Group         = module.subredes_privadas.SG_id
  ubicacion_public_key = var.RUTA_LLAVE_PUBLICA
  AZs                  = var.AV_ZONES_WINDOWS
  win_server_ami       = var.WIN_SERVER_AMI
  region               = var.REGION
  tipo_instancia       = var.TIPO_INSTANCIA_WINDOWS
  win_o_linux          = "windows"
  instance_username    = var.INSTANCE_USERNAME
  instance_password    = var.INSTANCE_PASSWORD
}

#--------------------- NLB ----------------------------------
module "NLB_balanceador_carga" {
  source           = "../modules/nlb"
  proyecto         = var.NOMBRE_PROYECTO
  el_id_de_la_VPC  = aws_vpc.mi_red.id
  los_IDs_subredes = module.subredes_privadas.IDs_subredes_Forma_1[0]
  sec_group_id     = module.vm_linux_privada.ID_Sec_Group
  id_vm_linux      = module.vm_linux_privada.IDs_vms[0]
  id_vm_windows    = module.vm_windows_privada.IDs_vms[0]
  protocolo        = "TCP"
  puerto_1         = 80
  puerto_2         = 8080
  tipo_balanceador = "network"
}
#-------------------------------------------------------------
