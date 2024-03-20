#!/bin/bash

# Pegar data atual
data_atual=$(date +"%Y%m%d")

#Criando diretório "vendas/" e copiando "dados_de_vendas.csv" 
#para dentro de vendas

mkdir -p vendas
cp dados_de_vendas.csv vendas/

#Entrando no diretório "vendas/" | Criando um subdiretório "backup/"
#Copiando "dados_de_vendas.csv" para dentro do subdiretório e renomeando
cd vendas/
mkdir -p backup
cp dados_de_vendas.csv backup/backup-dados-${data_atual}.csv

cd backup
touch relatorios.txt

#Teste
#echo ${data_atual}


{
	
	echo "Data do Sistema: $(date +'%Y/%m/%d %H:%M')"
	echo ""

	primeira_data_venda=$(awk -F "," 'NR==2 {print $5}' ../dados_de_vendas.csv)

	echo "Data da primeira venda: $primeira_data_venda"
	echo ""

	ultima_data_venda=$(tail -n 1 ../dados_de_vendas.csv | awk -F "," '{print $5}')

        echo "Data da última venda: $ultima_data_venda"
	echo ""

	total_itens=$(awk -F ',' 'NR>1 {print $2}' ../dados_de_vendas.csv | sort -u | wc -l)

	echo "Quantidade total de itens diferentes vendidos: $total_itens itens"

	echo ""

	head backup-dados-${data_atual}.csv

	zip backup-dados-${data_atual}.zip backup-dados-${data_atual}.csv

	rm backup-dados-${data_atual}.csv 
	rm ../dados_de_vendas.csv

} > relatorios-${data_atual}.txt

