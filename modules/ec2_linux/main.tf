resource "aws_instance" "mis_vms" {
  count                       = var.cantidad_instancias
  ami                         = var.win_server_ami[var.region] #var.imagen_OS 
  instance_type               = var.tipo_instancia
  availability_zone           = var.AZs[count.index]
  subnet_id                   = var.los_IDs_subredes[count.index]
  vpc_security_group_ids      = [var.ID_Sec_Group]
  user_data                   = data.template_file.userdata_linux_ubuntu.rendered
  key_name                    = aws_key_pair.mi_ssh_key.key_name

  tags = { Name = "svr-${var.win_o_linux}-${var.proyecto}-${count.index + 1}" }
}

resource "aws_key_pair" "mi_ssh_key" {
  key_name = "srv-key-pair"
  public_key = file(var.ubicacion_public_key)
}

data "template_file" "userdata_linux_ubuntu" {
  template = <<-EOT
              #!/bin/bash
              echo "ubuntu:123456" | chpasswd
              sudo apt update -y && sudo apt upgrade -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo mkdir /var/www/html/pagos/
              sudo touch /var/www/html/pagos/index.html
              echo "<h1>Esta la App de ${var.la_aplicacion_1}</h1>" | sudo tee /var/www/html/pagos/index.html
              sudo mkdir /var/www/html/compras/
              sudo touch /var/www/html/compras/index.html
              echo "<h1>Esta la App de ${var.la_aplicacion_2}</h1>" | sudo tee /var/www/html/compras/index.html
              sudo useradd -m -p 123456 -s /bin/bash vincenup
              echo "Este es un texto de prueba" > /home/ubuntu/a_file.txt
              echo "El nombre del proyecto es ${var.proyecto}" > /home/ubuntu/b_file.txt
              sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
              sudo sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
              sudo service sshd restart
              EOT
}