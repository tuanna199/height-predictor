#!bin/bash




bcftools view -i 'ID=@../data/processed/height_snps.txt' "../data/processed/EUR.QC.vcf" -O v -o ../data/processed/height.vcf

bcftools query -f '%ID\t[%GT\t]\n' ../data/processed/height.vcf > ../data/processed/height_genotyped.txt

sed -i 's/0\/0/0/g; s/0\/1/1/g; s/1\/0/1/g; s/1\/1/2/g' ../data/processed/height_genotyped.txt

