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

#for i in {21..22}; do python ${PRS_CS_LOC}/PRScs.py \
#--ref_dir=${SCRATCH_LOC}/ldblk_1kg_eur --bim_prefix=${SCRATCH_LOC}/Script1Step1/ADHD_chr${i} \
#--sst_file=/scratch/c.c1603689/Dissertation/SUMSTATS.txt --n_gwas=14307 --chrom=${i} --out_dir=${SCRATCH_LOC}/Script1Step2/
#done

python ${PRS_CS_LOC}/PRScs.py \
--ref_dir=${SCRATCH_LOC}/ldblk_1kg_eur \
--bim_prefix=${SCRATCH_LOC}/Script1Step1/ADHD_chr${CHR} \
--sst_file=/scratch/c.c1603689/Dissertation/SUMSTATS.txt \
--n_gwas=14307 \
--chrom=${CHR} \
--out_dir=${SCRATCH_LOC}/Script1Step2/
