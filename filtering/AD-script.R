##################################################################
##
## VARIANT FILTERING
## Removing all variants that occur more often than 6 times
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################
# load library
library(stringr)
library(dplyr)
library(data.table)

# gene list
gene <- c("Cab035983.1", "Bo3g168810.1", "Cab045628.2", "Cab023705.1", "Bo1g139590.1", "Bo5g134730.1")

# set wd
scrDir <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts")
setwd(scrDir)

# function for analysis
Less6 <- function(X){
    Flag <- sum(as.numeric(as.numeric(X) > 0)) <= 6
    return(Flag)
}

##################################################################
##
## FILTER LOOP
##
##################################################################

for(i in 1:length(gene)){
# set vcf - results directory
    genDir <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/results/", gene[i], "/vcf" )
    setwd(genDir)

# try to detect if previous files exist
    if(file.exists(paste0("AD-SNP-",gene[i], ".vcf"))){
        try(snp <- read.table(paste0("AD-SNP-",gene[i], ".vcf")), silent = T)
    }

    if(file.exists(paste0("AD-INDEL-", gene[i], ".vcf"))){
        try(indel <- read.table(paste0("AD-INDEL-", gene[i], ".vcf")), silent = T)
    }

##################################################################
## SNPs
    try(if(str_detect(snp[1,1], pattern = "[A-Z]")){
    
    #load data
        AD <- fread(paste0("AD-SNP-", gene[i], ".vcf"), header = F, select=c(6:589))
    # names
        snpNames <- fread(paste0("AD-SNP-", gene[i],".vcf"), header=F, select=c(1:4))
    
    # duplicate POS
        snpNames$V5 <- snpNames$V2-1

    # reorder
        snpNames <- snpNames[, c(1,5,2,3,4)]
    
    # change column names
        colnames(snpNames) <- c("chrom", "chromStart", "chromEnd", "REF", "ALT")

    # apply function to AD scores
        filtered <- apply(AD, 1, Less6)

    # get names with < 6 occurances
        results <- snpNames[filtered, ]

    # save as txt file
        write.table(results, file = paste0("Val-SNP-", gene[i], ".bed"), sep = "\t", row.names = F, col.names = T, quote = F)
        }, silent = T)

##################################################################
## INDELs

    try(if(str_detect(indel[1,1], pattern = "[A-Z]")){
    
    # load data
        AD <- fread(paste0("AD-INDEL-", gene[i], ".vcf"), header = F, select=c(6:589))
    # names
        snpNames <- fread(paste0("AD-INDEL-", gene[i],".vcf"), header=F, select=c(1:4))
    
    # duplicate POS --> chromStart
        snpName$V5 <- snpNames$V2-1
    
    # reorder
        snpNames <- snpNames[, c(1,5,2,3,4)]
    
    # change column names
        colnames(snpNames) <- c("chrom", "chromStart", "chromEnd", "REF", "ALT")
    
    # apply function to AD scores
        filtered <- apply(AD, 1, Less6)
    
    # get names with < 6 occurances
        results <- snpNames[filtered, ]
    
    # save as txt file
        write.table(results, file = paste0("Val-INDEL-", gene[i], ".bed"), sep = "\t", row.names = F, col.names = T, quote = F)
        }, silent = T)
}

##################################################################