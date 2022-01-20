output Rango_de_IPs_Subred { value  = aws_subnet.mi_subred[*].cidr_block }

output IDs_subredes_Forma_1 { 
    value = aws_subnet.mi_subred[*].id
}
output IDs_subredes_Forma_2 { 
    value = aws_subnet.mi_subred.*.id
}
output IDs_subredes_Forma_3 {
    value = [for elemento in aws_subnet.mi_subred : elemento.id]
}

output SG_id { value = aws_security_group.mi_sec_group.id }
