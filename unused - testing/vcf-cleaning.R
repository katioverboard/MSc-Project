##################################################################
##
## VCF ANALYSIS
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################

# load library
library(stringr)

# regular vcf loading
vcf <- read.table("final-SNP-Bo5g134730.1.vcf", header = T, stringsAsFactors = F)

## extract format values
read.vcf = function(file, special.char="##", ...) {
    my.search.term=paste0(special.char, ".*")
    all.lines=readLines(file)
    clean.lines=gsub(my.search.term, "",  all.lines)
    clean.lines=gsub("#CHROM", "CHROM", clean.lines)
    read.table(..., text=paste(clean.lines, collapse="\n"))
}

# load vcf with function
test <- read.vcf("final-SNP-Bo5g134730.1.vcf", header = T, stringsAsFactors = F)

# get only Format values
values <- test[1:nrow(test),10:length(test)]

##################################################################
##
## VARIANT FILTERING
##
##################################################################

# make new data frame
filter <- data.frame()
names(filter) <- names(values)

# loop through data set, get only those less with 6, replace else with NA?
for(i in 1:length(values)){
  for( k in 1:nrow(values)){
    if(str_detect(values[i,k], pattern = ":[0-9]+,[7-9]$")){
      filter <- (str_replace(values, pattern = ":[0-9]+,[7-9]$", replacement = "NA"))
    }
    else(filter <- values[i,k])
  }
}



