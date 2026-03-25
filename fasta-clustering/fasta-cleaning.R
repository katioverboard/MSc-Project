##################################################################
##
## FASTA CLUSTERING
## cleaning fasta clusters
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################

library(Biostrings)
library(stringr)

# read file in
fasta <- readDNAStringSet("cleaner.fasta")

seqnames <- names(fasta)

# rewrite reference
seqnames <- str_replace(seqnames, pattern = "AA_Chr08:13383605-13385125",
                        replacement = "ref")

# analysing how many sequences were merged
grep(pattern = "_", seqnames)

## reference, 4, 5, 6, 7, 8, 9, 15[1.1]

cleannames <- str_remove_all(string = seqnames, pattern = "_R.*$")
duplicatedSeqs <- grep(pattern = "_", seqnames)
for (i in 1:length(duplicatedSeqs)){
	seqIndex <- duplicatedSeqs[i] 
	duplicatedSeqsCount <- str_count(pattern = "_R", string = seqnames[seqIndex]) 
	cleannames[seqIndex] <- paste(cleannames[seqIndex], " and ", duplicatedSeqsCount, "Samples") #"ref + Cluster 104"
}
#
# > cleannames
# [1] "ref  and  104 Samples" "R04"                   "R08"
# [4] "R103  and  4 Samples"  "R104  and  17 Samples" "R108  and  29 Samples"
# [7] "R111  and  1 Samples"  "R114  and  5 Samples"  "R122  and  1 Samples"
# [10] "R127"                  "R134"                  "R148"
# [13] "R165"                  "R17"                   "R170  and  1 Samples"
# [16] "R177"                  "R29"                   "R64"
# [19] "R87"                   "R90"                   "R95"
# [22] "R96" 

# remove additional names
cleannames <- str_remove_all(string = seqnames, pattern = "_R.*$")

# count merges + rename
str_count(pattern = "[R|r]", string = seqnames[1]) # 105
cleannames <- str_replace(seqnames, pattern = seqnames[1],
                        replacement = "ref + Cluster 104")

str_count(pattern = "R", string = seqnames[4]) # 5
cleannames <- str_replace(string = cleannames, pattern = cleannames[4],
            replacement = "Cluster 5")

str_count(pattern = "R", string = seqnames[5]) # 18
cleannames <- str_replace(string = cleannames, pattern = cleannames[5],
            replacement = "Cluster 18")

str_count(pattern = "R", string = seqnames[6]) # 30
cleannames <- str_replace(string = cleannames, pattern = cleannames[6],
            replacement = "Cluster 30")

str_count(pattern = "R", string = seqnames[7]) # 2
cleannames <- str_replace(string = cleannames, pattern = cleannames[7],
            replacement = "Cluster 2")

str_count(pattern = "R", string = seqnames[8]) # 6
cleannames <- str_replace(string = cleannames, pattern = cleannames[8],
                        replacement = "Cluster 6")

str_count(pattern = "R", string = seqnames[9]) # 2
cleannames <- str_replace(string = cleannames, pattern = cleannames[9],
                        replacement = "Cluster 2")

str_count(pattern = "R", string = seqnames[15]) # 2
cleannames <- str_replace(string = cleannames, pattern = cleannames[15],
                        replacement = "Cluster 2")

# rename the file
cleanfasta <- fasta
names(cleanfasta) <- cleannames

# save as fasta
writeXStringSet(cleanfasta, filepath = "clean-fasta.fa")

##################################################################