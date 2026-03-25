##################################################################
##
## EXON FILTERING
## Removing all non-exon variants
## Creation of smaller files
## Applying Quality Control
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################

args <- commandArgs(T)
cat(args, sep = "\n")

# load library
library(stringr)

# gene list
gene <- c("Cab035983.1", "Bo3g168810.1", "Cab045628.2", "Cab023705.1", "Bo1g139590.1", "Bo5g134730.1")

scrDir <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts")
setwd(scrDir)

##################################################################
##
## FILTER LOOP
##
##################################################################

for(i in 1:length(gene)){
    setwd(scrDir) # reset wd
    sh.file <- paste0("vcf/sh/exon-", gene[i], ".sh",  sep="")
    log.file <- paste0("../log/exon-", gene[i], ".log", sep="")
    cat(paste0("#!/bin/bash\n#SBATCH --job-name=",sh.file,"\n#SBATCH --mail-type=NONE\n#SBATCH --mail-user=kg913@york.ac.uk\n#SBATCH --ntasks=16\n#SBATCH --mem=10gb\n#SBATCH --time=11:59:00\n#SBATCH --output=",log.file,"\n#SBATCH --account=biol-pgen-2019\ndate\n"), file=sh.file)
# load modules
    cat("module load bio/BEDTools\n
    module load bio/BCFtools/1.10.2-GCC-9.3.0\n
    module load bio/VCFtools\n",
        file=sh.file, append=TRUE, sep="")

# change directories
    cat("cd /mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/results/", gene[i], "/vcf\n",
        file=sh.file, append=TRUE, sep="")

# change directories (in R)
    vcfDir <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/results/", gene[i], "/vcf")
    setwd(vcfDir)

# load vcf for analysis (which chromosome)
    vcf <- read.table(paste0(gene[i],"-SNP.vcf"))

#INDEL file
    try(indel <- read.table(paste0(gene[i],"-INDEL.vcf")), silent = T)

# change to script dir again
    setwd(scrDir)

# choose right .gff file - chromosome
    if(str_detect(vcf[1,1], pattern =  "^C")){
        cat("bedtools intersect -header -a ", gene[i],"-SNP.vcf -b ../../../reference/C-exon.gff > exon-SNP-", gene[i],".vcf\n",
            file=sh.file, append=TRUE, sep="")
    } else if (str_detect(vcf[1,1], pattern = "^A")){
        cat("bedtools intersect -header -a ", gene[i],"-SNP.vcf -b ../../../reference/A-exon.gff > exon-SNP-", gene[i],".vcf\n",
            file=sh.file, append=TRUE, sep="")
    }

# repeat for INDEL files 
    try(if(str_detect(indel[1,1], pattern =  "^C") ){
        cat("bedtools intersect -header -a ", gene[i],"-INDEL.vcf -b ../../../reference/C-exon.gff > exon-INDEL-", gene[i],".vcf\n",
            file=sh.file, append=TRUE, sep="")
    } else if (str_detect(indel[1,1], pattern = "^A")){
        cat("bedtools intersect -header -a ", gene[i],"-INDEL.vcf -b ../../../reference/A-exon.gff > exon-INDEL-", gene[i],".vcf\n",
            file=sh.file, append=TRUE, sep="")
    }, silent = T)

# change directories to analyse exon-files
    setwd(vcfDir)

# load exon-SNP and INDEL files
    if(file.exists(paste0("exon-SNP-",gene[i], ".vcf"))){
        try(exonsnp <- read.table(paste0("exon-SNP-",gene[i], ".vcf")), silent = T)
    }

# load exon-INDEL
    if(file.exists(paste0("exon-INDEL-", gene[i], ".vcf"))){
        exonindel <- read.table(paste0(gene[i],"-INDEL.vcf"))
    }

    setwd(scrDir)

##################################################################
##
## QUALITY CONTROL
##
## Continue only if exon files exist
## remove Q < 30 and if > 50% data is missing
##
##################################################################

    try(if(str_detect(exonsnp[1,1], pattern = "[A-Z]")){
        cat("vcftools --vcf exon-SNP-", gene[i], ".vcf --max-missing 0.5 --minQ 30 --recode --recode-INFO-all --out filter-SNP-", gene[i], ".vcf\n",
            file=sh.file, append=TRUE, sep="")
    
    # rename + remove file
        cat("cp filter-SNP-", gene[i], ".vcf.recode.vcf filter-SNP-", gene[i], ".vcf\n",
            file=sh.file, append=TRUE, sep="")
    
    # remove .recode.vcf file
        cat("rm filter-SNP-", gene[i], ".vcf.recode.vcf\n",
            file=sh.file, append=TRUE, sep="")
        } , silent = T)

    try(if(str_detect(exonindel[1,1], pattern = "[A-Z]")){
        cat("vcftools --vcf exon-INDEL-", gene[i], ".vcf --max-missing 0.5 --minQ 30 --recode --recode-INFO-all --out filter-INDEL-", gene[i], ".vcf\n",
            file=sh.file, append=TRUE, sep="")
    
    # rename + remove file
        cat("cp filter-INDEL-", gene[i], ".vcf.recode.vcf filter-INDEL-", gene[i], ".vcf\n",
            file=sh.file, append=TRUE, sep="")
    
        cat("rm filter-INDEL-", gene[i], ".vcf.recode.vcf\n",
            file=sh.file, append=TRUE, sep="")
        }, silent = T)

##################################################################
##
## SNPs only:
## apply RPB > 0.5 || RPB < -0.5

    try(if(str_detect(exonsnp[1,1], pattern = "[A-Z]")){
        cat("bcftools filter -e 'RPB > 0.5 || RPB < -0.5' filter-SNP-", gene[i], ".vcf > final-SNP-", gene[i],".vcf\n",
            file=sh.file, append=TRUE, sep="")
    }, silent = T)
}

##################################################################