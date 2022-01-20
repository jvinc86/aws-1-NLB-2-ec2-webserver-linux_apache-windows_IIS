resource "aws_instance" "mis_vms" {
  count                       = var.cantidad_instancias
  ami                         = var.win_server_ami[var.region] #var.imagen_OS 
  instance_type               = var.tipo_instancia
  availability_zone           = var.AZs[count.index]
  subnet_id                   = var.los_IDs_subredes[count.index]
  vpc_security_group_ids      = [var.ID_Sec_Group]
  user_data                   = data.template_file.userdata_win.rendered
  # key_name                    = aws_key_pair.mi_ssh_key.key_name

  tags = { Name = "svr-${var.win_o_linux}-${var.proyecto}-${count.index + 1}" }
}

# resource "aws_key_pair" "mi_ssh_key" {
#   key_name = "srv-key-pair"
#   public_key = file(var.ubicacion_public_key)
# }

data "template_file" "userdata_win" {
  template = <<-EOF
                <powershell>
                  net user ${var.instance_username} /add /y
                  net user ${var.instance_username} ${var.instance_password}
                  net localgroup administrators ${var.instance_username} /add
                  netsh advfirewall set allprofiles state off
                  Install-WindowsFeature -name Web-Server -IncludeManagementTools
                  Set-WebBinding -Name "Default Web Site" -BindingInformation "*:80:" -PropertyName "Port" -Value "8080"
                </powershell>
                <persist>false</persist>
              EOF
}