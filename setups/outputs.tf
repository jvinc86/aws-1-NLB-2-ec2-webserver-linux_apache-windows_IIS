output "EC2_Linux_IP_privada" { value = module.vm_linux_privada.mis_ip_privadas }
output "EC2_Linux_IP_PUBLICA" { value = module.vm_linux_privada.mis_ip_publicas }

output "EC2_Windows_IP_privada" { value = module.vm_windows_privada.mis_ip_privadas }
output "EC2_Windows_IP_PUBLICA" { value = module.vm_windows_privada.mis_ip_publicas }

output "URL_del_NLB" { value = module.NLB_balanceador_carga.dns_name_del_balanceador }


# output "El_ID_VPC" { value = aws_vpc.mi_red.id }
# output "Router_Nuevo_ID_VPC" { value = aws_vpc.mi_red.main_route_table_id }

# output "IDs_subredes_SPLASH" {
#   value = module.subredes_privadas.IDs_subredes_Forma_1
# }
# output "IDs_subredes_SPLASH_2" {
#   value = module.subredes_privadas.IDs_subredes_Forma_2
# }
# output "IDs_subredes_FOR_IN" {
#   value = module.subredes_privadas.IDs_subredes_Forma_3
# }

# output "Subredes" { value = module.subredes_privadas.Rango_de_IPs_Subred }
