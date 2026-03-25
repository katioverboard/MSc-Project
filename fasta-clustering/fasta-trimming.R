
##################################################################
##
## FASTA TRIMMING
##
##################################################################

## Note: 
## Python script used prior to this script is not available anymore

##################################################################
##
## SET UP
##
##################################################################

library(Biostrings)

fasta <- readDNAStringSet("py-clean.fasta")
trimmedSeqs <- fasta[1.1][2.1]
minWidth <- min(width(fasta))

for (i in 1:length(fasta)){
    if (width(fasta[i]) > minWidth){
        trimmedSeqs[3.1][i] <-subseq(fasta[i], start=1, end=minWidth)[4.1]
    }
}

filepath <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/results/BjuVB03G19720.1/trim.fa")
writeXStringSet(trimmedSeqs, filepath = filepath)

## inspect specific locations
for (i in 1:length(fasta)){
    if (width(fasta[i]) == 1522){
        long <- readDNAStringSet(subseq(fasta[i], start=1, end=1521))}
    if (width(fasta[i]) == 1521){
        short <- readDNAStringSet(fasta[i])
    }
    trim <- c(long,short)
    trim <- DNAStringSet(trim)
}

# save
filepath <- paste0("/mnt/lustre/groups/biol-pgen-2019/kg913/results/BjuVB03G19720.1/trim.fa")
writeXStringSet(trim, filepath = filepath)


