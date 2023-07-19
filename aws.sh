#!/bin/bash

# Função para imprimir o texto com a cor desejada
print_colored() {
    local color_code=$1
    local text=$2
    echo -e "\e[${color_code}${text}\e[0m"
}

# Função para listar instâncias EC2 em uma região específica
list_ec2_instances() {
    local region=$1
    echo "Região: $region" >> "$output_file"
    instances_info=$(aws ec2 describe-instances --region "$region" --query 'Reservations[].Instances[].[Tags[?Key==`Name`]|[0].Value, InstanceId, PublicIpAddress, State.Name]' --output json)
    while IFS=$'\t' read -r name instance_id ip state; do
        if [[ "$state" == "running" ]]; then
            color_code="32m"  # Verde (32) para instância ligada
        else
            color_code="31m"  # Vermelho (31) para instância desligada
        fi
        print_colored "$color_code" "Nome: $name"
        print_colored "$color_code" "ID da Instância: $instance_id"
        print_colored "$color_code" "IP Público: $ip"
        echo -e "\e[0m-------------------------------------"
    done < <(echo "$instances_info" | jq -r '.[] | @tsv')
}

# Função para listar instâncias RDS em uma região específica
list_rds_instances() {
    local region=$1
    echo "Região: $region" >> "$output_file"
    instances_info=$(aws rds describe-db-instances --region "$region" --query 'DBInstances[].[DBInstanceIdentifier, DBInstanceStatus]' --output json)
    while IFS=$'\t' read -r name status; do
        if [[ "$status" == "available" ]]; then
            color_code="32m"  # Verde (32) para instância disponível
        else
            color_code="31m"  # Vermelho (31) para instância indisponível
        fi
        print_colored "$color_code" "Nome: $name"
        print_colored "$color_code" "Status: $status"
        echo -e "\e[0m-------------------------------------"
    done < <(echo "$instances_info" | jq -r '.[] | @tsv')
}

# Nome do arquivo de saída
output_file="resultado_instancias.txt"

# Listar instâncias EC2 em todas as regiões
REGIONS_EC2=$(aws ec2 describe-regions --query 'Regions[].[RegionName]' --output text)
for region in $REGIONS_EC2; do
    list_ec2_instances "$region"
done

# Listar instâncias RDS em São Paulo (us-east-1)
list_rds_instances "sa-east-1"

# Listar instâncias RDS em Ohio (us-west-2)
list_rds_instances "us-west-2"

echo "Resultado gravado em $output_file"
