##################################################################
##
## Main script for analysing bam files
##
## Pipeline:
## sorted .bam -> mapped .fastq + consensus .fasta + .vcf files
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################

# Rscript [gene ID]
# directory: mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts

#load library
library(stringr)
library(data.table)

# CLI parsing
args <- commandArgs(T)
cat(args, sep = "\n")
ID <- args[1] # ID = gene ID (eg. Cab020592.1)

filenames <- dir("../../../Gamma/bam/", pattern=".sorted.bam$")
exp.condition <- gsub(".sorted.bam", "", filenames)

# read gtf file
geneReference <- fread("../../../Gamma/reference/ref.gtf", header=F) 

# remove ID
geneReference$V9 <- gsub("ID=", "", geneReference$V9)

# find gene
gene <-geneReference[geneReference$V9 == ID]
gene <- as.character(gene)

## eg: "AA_Chr08_013383605_013385125"

# get allele
allele <- str_c(str_subset(string = gene, pattern = "[A-C][0-9]{2,}"))

# get position
position <- str_c(str_subset(string = gene, pattern = "\\b[0-9]{2,}"), collapse = "-")

# colon
colon <- ":"

# together
str_c(allele, colon, position)

# coordinates together
coord <- str_c(allele, colon, position) #(A01:19956-21944) 

# add ID
genecoord <- str_c(ID, coord, sep = "\n")

# save file
write.table(genecoord, file= paste(ID, ".txt"))
##################################################################
##
## FOLDER MGMT
##
##################################################################
##
## Structure: results/[gene ID]/[analysed files]


# create folder for bam files
mainDir <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/results")
subDir <- ID

setwd(mainDir)

# no duplicate folders
if (file.exists(subDir)){
    setwd(file.path(mainDir, subDir))
} else {
    dir.create(file.path(mainDir, subDir))
    setwd(file.path(mainDir, subDir))
}

# create subdirectories for fasta/vcf/fastq files
minDir <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/results/", ID)
list <- c("fasta", "vcf", "fastq", "bam")

setwd(minDir)

for(l in 1:length(list)){
    if (file.exists(list[l])){
    setwd(file.path(minDir, list[l]))
    }else {
    dir.create(file.path(minDir, list[l]))
    setwd(file.path(minDir, list[l]))
    }
}

##################################################################
##
## Structure: scripts/[gene ID]/sh (scripts for respective gene)
## and: scripts/[gene ID]/log

# create folder with ID
scrDir <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts")

if (file.exists(subDir)){
    setwd(file.path(scrDir, subDir))
} else {
    dir.create(file.path(scrDir, subDir))
    setwd(file.path(scrDir, subDir))
}

# create subdirectories
scrDir2 <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts/", ID)
scr <- c("sh", "log")

for(s in 1:length(scr)){
    if (file.exists(scr[s])){
    setwd(file.path(scrDir2, scr[s]))
    }else {
    dir.create(file.path(scrDir2, scr[s]))
    setwd(file.path(scrDir2, scr[s]))
    }
}

# setwd to original
setwd(paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts"))

##################################################################
## 
## SCRIPT CREATION
##
##################################################################

## loop for bam files
for(i in 1:length(exp.condition)){
    sh.file <- paste(ID, "/sh/", exp.condition[i], "-", ID, ".sh", sep="")
    log.file <- paste("../log/", exp.condition[i], "-", ID, ".log", sep="")
    cat(paste0("#!/bin/bash\n#SBATCH --job-name=",sh.file,"\n#SBATCH --mail-type=NONE\n#SBATCH --mail-user=kg913@york.ac.uk\n#SBATCH --ntasks=16\n#SBATCH --mem=10gb\n#SBATCH --time=11:59:00\n#SBATCH --output=",log.file,"\n#SBATCH --account=biol-pgen-2019\ndate\n"), file=command1)

# loading modules
    cat("module load bio/SAMtools\n
    module load bio/SeqKit\n
    module load bio/BCFtools/1.10.2-GCC-9.3.0\n
    module load bio/VCFtools/0.1.15-foss-2018b-Perl-5.26.1\n
    module load lang/R\n",  file=sh.file, append=TRUE, sep="")

# get subregion
    cat("samtools view -h ../../../../../Gamma/bam/", exp.condition[i], ".sorted.bam ", coord,
        " > ../../../results/", ID, "/bam/", exp.condition[i], ".sub.sort.bam\n",
        file = sh.file, append = T, sep = "")

# get fastq
    cat("samtools mpileup -uf ../../../../../Gamma/reference/ref.fa ../../../results/", ID,
        "/bam/", exp.condition[i], ".sub.sort.bam | bcftools call -c | ",
        "vcfutils.pl vcf2fq > ../../../results/", ID, "/fastq/", ID, "-fq.fastq\n",
        file=sh.file, append=T, sep = "")

# get mapped fastq
    cat("samtools bam2fq ../../../results/", ID, "/bam/", exp.condition[i],".sub.sort.bam",
        " > ../../../results/", ID, "/fastq/", exp.condition[i], "-mapped.fastq\n",
        file = sh.file, append = T, sep = "")

# get vcf - all in one
    cat("bcftools mpileup -f ../../../../../Gamma/reference/ref.fa ../../../results/", ID, "/bam/*.bam",
        "| bcftools call -mv",
        " > ../../../results/", ID, "/vcf/", ID, ".vcf\n",
        file = sh.file, append = T, sep = "")

# consensus from reference
    cat("samtools faidx ../../../../../Gamma/reference/ref.fa ", coord,
        " > ../../../results/", ID, "/fasta/", ID, "-reference.fa\n",
        file = sh.file, append=T, sep = "")

# clean fasta
    cat("bcftools mpileup -f ../../../../../Gamma/reference/ref.fa ../../../results/", ID, "/bam/", exp.condition[i], ".sub.sort.bam",
        "| bcftools call -mv -O z > ../../../results/", ID, "/fasta/", exp.condition[i], ".vcf.gz\n ",
        "tabix -p vcf ../../../results/", ID, "/fasta/", exp.condition[i], ".vcf.gz\n ",
        "samtools faidx ../../../../../Gamma/reference/ref.fa ", coord,
        " | bcftools consensus -I ../../../results/", ID, "/fasta/", exp.condition[i], ".vcf.gz ",
        "> ../../../results/", ID, "/fasta/", exp.condition[i], "-cns.fa\n",
        file = sh.file, append=T, sep = "")
}

##################################################################