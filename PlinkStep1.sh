#!/bin/bash
#SBATCH -p compute
#SBATCH --job-name=PRSADHD
#SBATCH -o %J_%a.out
#SBATCH -e %J_%a.err
#SBATCH -t 00:40:00
#SBATCH --mem-per-cpu=10GB
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH --account=scw1792
#SBATCH --array=1-22

##### SET-UP
echo -e "***** Script started on `date` *****\n"
# Assign the script arguments to meaningful objects
SCRATCH_LOC=$1
PRS_CS_LOC=$2
DISC=$3
DISC_N=$4
CHR=${SLURM_ARRAY_TASK_ID}
# working directory:
cd ${SCRATCH_LOC}/PRS/
# MODULES
module load anaconda/3

##### REQUIRED files:
echo -e "***** Check all required files are where they need to be:"
# FINAL PLINK BED format files:
ls /gluster/neurocluster/projects/Pathfinder_Data_Repository/SAGE/postQC_JM/ADHD_cleaned.*
ls ${SCRATCH_LOC}/summaRygwasqc/TS_Oct2018_SGWQC/TS_Oct2018summaRyQC.txt.gz

##### MAIN SCRIPT
echo -e "\n***** STEP 1: EXTRACT THE DATA FOR THE CHR - NEEDED FOR PRS-CS *****\n"
# only need to run once
for i in {1..22}; do module load plink/1.9
 echo -e "Plink Version 1.9 has been loaded"
plink --bfile /gluster/neurocluster/projects/Pathfinder_Data_Repository/SAGE/postQC_JM/ADHD_cleaned --chr ${i} --make-bed --out ${SCRATCH_LOC}/Script1Step1/ADHD_chr${i}
done
