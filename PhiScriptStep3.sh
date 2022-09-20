#!/bin/bash
#SBATCH -p compute
#SBATCH --job-name=prscs
#SBATCH -o %J.out
#SBATCH -e %J.err
#SBATCH -t 00:05:00
#SBATCH --mem-per-cpu=1GB
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH --account=scw1792

##### SET-UP
echo -e "***** Script started on `date` *****\n"
# Assign the script arguments to meaningful objects
SCRATCH_LOC=$1
PLINK_LOC=$2
DISC=$3

echo -e "\n***** STEP 1: CALCULATE VALUE OF THE WEIGHTED PHI PARAMETER USED BY PRS-CS-AUTO *****\n"
# create a table containing information the per-CHR number of SNPs and
# global shrinkage parameter (phi) estimated by the auto option

cd /scratch/c.c1603689/Dissertation/Script1Step2/
for i in {1..22}; do echo ${i} >> auto_phi_check1 
wc -l _pst_eff_a1_b0.5_phiauto_chr${i}.txt | awk '{print $1}' >> auto_phi_check2 
grep global /scratch/c.c1603689/Dissertation/*_${i}.out | awk '{print $6}' >> auto_phi_check3
done
paste auto_phi_check1 auto_phi_check2 auto_phi_check3 > auto_phi_check
cat auto_phi_check
rm auto_phi_check1 auto_phi_check2 auto_phi_check3

# use R to calculate the weighted average:
module load R
cat > R8_mean_phi_KM.R<<EOF
df <- read.table('auto_phi_check', header=F, col.names=c("CHR","size","phi"))
total=sum(df[,2])
total
# weights for each chr based on their size
df[,4]<-df[,2]/total
# values of phi multiplied by weight
df[,5]<-df[,4]*df[,3]
# weighted average value of phi:
sum(df[,5])
EOF
echo -e "\n***** The number of SNPs the PRS are based on & the average value of PHI across the genome (weighted by CHR size):"
Rscript --vanilla R8_mean_phi_KM.R

echo -e "\n***** STEP 2: CALCULATE PRS IN PLINK USING NEW BETAS *****\n"
# Prepare the PRS-CS output files - concatenate them and add a header
cat _pst_eff_a1_b0.5_phiauto_chr*.txt | \
awk 'BEGIN{print "CHR SNP BP A1 A2 CS_beta"}{print $1,$2,$3,$4,$5,$6}' \
> PRS_CS_betas_${DISC}

#module load plink \
#plink --bfile /gluster/neurocluster/projects/Pathfinder_Data_Repository/SAGE/postQC_JM/ADHD_cleaned  --score /scratch/c.c1603689/Dissertation/Script1Step2/PRS_CS_betas_${DISC} 2 4 6 header no-mean-imputation --out /scratch/c.c1603689/Dissertation/Script2Step3/ADHD_${DISC}_PRS_CS_auto
