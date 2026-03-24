##################################################################
##
## Testing: GATK Tool
##
## Pipeline:
## sorted.bam -> .vcf
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################

# Rscript [gene ID]
# directory: mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts

args <- commandArgs(T)
cat(args, sep = "\n")
ID <- args[1] # ID = gene ID (eg. Cab020592.1)

# get files
filenames <- dir("../../../Gamma/bam/Radiation/", pattern=".sorted.bam$")
exp.condition <- gsub(".sorted.bam", "", filenames)

##################################################################
## 
## SCRIPT CREATION
##
##################################################################

## full command:
## gatk Mutect2 -R ../../../Gamma/reference/ref.fa -I ../../../Gamma/bam/Control/Control_16.sorted.bam -O test.vcf

# loop through bam files
for(i in 1:length(exp.condition)){
    sh.file <- paste("../results/gatk/",ID, "-gatk.sh", sep="")
    log.file <- paste(ID, "gatk.log", sep="")
    cat(paste0("#!/bin/bash\n#SBATCH --job-name=",sh.file,"\n#SBATCH --mail-type=NONE\n#SBATCH --mail-user=kg913@york.ac.uk\n#SBATCH --ntasks=16\n#SBATCH --mem=10gb\n#SBATCH --time=11:59:00\n#SBATCH --output=",log.file,"\n#SBATCH --account=biol-pgen-2019\ndate\n"), file=command1)
# loading modules
    cat("module load bio/GATK\n",
    file=sh.file, append=TRUE, sep="")
# first line
    cat("gatk Mutect2 -R ../../../../Gamma/reference/ref.fa ",
        file=sh.file, append = T, sep = "")

# run all bam files
    for (s in 1:length(exp.condition)){
        cat("-I ../../../Gamma/bam/Radiation/", exp.condition[s], ".sorted.bam ",
            file = sh.file, append = T, sep = "")
}

# write into vcf
    cat("-O gatk.vcf\n",
        file = sh.file, append = T, sep ="")
}
##################################################################