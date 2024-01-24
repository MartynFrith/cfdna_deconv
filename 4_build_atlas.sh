#!/bin/sh
#SBATCH --job-name=build_atlas
#SBATCH -D /lustre/projects/Research_Project-MRC190311/WGBS/frith/wgbstools_DMR_calling/
#SBATCH -p mrcq # submit to the parallel queue
#SBATCH --time=06:00:00 # maximum walltime for the job
#SBATCH -A Research_Project-MRC190311 # research project to submit under
#SBATCH --nodes=16 # specify number of nodes
#SBATCH --ntasks-per-node=16 # specify number of processors per node
#SBATCH --mem=100G # specify bytes memory to reserve
#SBATCH --error=build_atlas.err
#SBATCH --mail-type=END # send email at job completion
#SBATCH --mail-user=mjf221@exeter.ac.uk # email address

cd /lustre/projects/Research_Project-MRC190311/software/wgbs_tools
export PATH=${PATH}:$PWD
cd /lustre/projects/Research_Project-MRC190311/software/UXM_deconv
export PATH=${PATH}:$PWD
cd /lustre/projects/Research_Project-MRC190311/WGBS/frith/wgbstools_DMR_calling/

source /lustre/home/mjf221/.bashrc
module load Anaconda3
conda activate /lustre/home/mjf221/.conda/envs/wgbstools_env

uxm build --markers find_markers_out/concat_markers_out.tsv --groups groups.csv --pats bam2pat_out/*.pat.gz --rlen 4 -o build_atlas_out/mjf221_atlas.txt
