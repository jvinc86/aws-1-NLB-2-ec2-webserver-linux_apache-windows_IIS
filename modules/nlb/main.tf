resource "aws_lb_target_group" "tg_linux" {
  name     = "tg-srv-linux-${var.proyecto}"
  port     = var.puerto_1
  protocol = var.protocolo
  vpc_id   = var.el_id_de_la_VPC
}

resource "aws_lb_target_group" "tg_windows" {
  name     = "tg-srv-windows-${var.proyecto}"
  port     = var.puerto_2
  protocol = var.protocolo
  vpc_id   = var.el_id_de_la_VPC
}

resource "aws_lb" "mi_nlb" {
  name               = "nlb-${var.proyecto}"
  internal           = false
  load_balancer_type = var.tipo_balanceador
  subnets            = [var.los_IDs_subredes] #[for i in range(0, 3) : var.los_IDs_subredes[i]]
}

resource "aws_lb_target_group_attachment" "asocia_vm_linux_a_tg" {
  target_group_arn = aws_lb_target_group.tg_linux.arn
  target_id        = var.id_vm_linux    #var.id_instancias[0]
  port             = var.puerto_1
}

resource "aws_lb_target_group_attachment" "asocia_vm_windows_a_tg" {
  target_group_arn = aws_lb_target_group.tg_windows.arn
  target_id        = var.id_vm_windows   #var.id_instancias[0]
  port             = var.puerto_2
}

resource "aws_lb_listener" "el_listener_nlb_linux" {
  load_balancer_arn = aws_lb.mi_nlb.arn
  protocol          = var.protocolo
  port              = var.puerto_1

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_linux.arn
  }
}

resource "aws_lb_listener" "el_listener_nlb_windows" {
  load_balancer_arn = aws_lb.mi_nlb.arn
  protocol          = var.protocolo
  port              = var.puerto_2

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_windows.arn
  }
}