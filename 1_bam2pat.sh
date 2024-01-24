#!/bin/sh
#SBATCH -p mrcq # submit to the mrc queue
#SBATCH --time=06:00:00 # maximum walltime for the job
#SBATCH -A Research_Project-MRC190311 # research project to submit under
#SBATCH --nodes=16 # specify number of nodes
#SBATCH --ntasks-per-node=16 # specify number of processors per node
#SBATCH --mem=100G # specify bytes memory to reserve
#SBATCH --output=frith/wgbstools_DMR_calling/logFiles/%u/bam2pat.out
#SBATCH --error=frith/wgbstools_DMR_calling/logFiles/%u/bam2pat.err
#SBATCH --mail-type=END # send email at job completion
#SBATCH --mail-user=mjf221@exeter.ac.uk # email address
cd /lustre/projects/Research_Project-MRC190311/software/wgbs_tools
export PATH=${PATH}:$PWD
cd /lustre/projects/Research_Project-MRC190311/WGBS/frith/wgbstools_DMR_calling/

source /lustre/home/mjf221/.bashrc
module load Anaconda3
conda activate /lustre/home/mjf221/.conda/envs/wgbstools_env

source config/%u/config.txt
wgbstools bam2pat $RAWDATADIR/build_atlas_bams -o bam2pat_out/