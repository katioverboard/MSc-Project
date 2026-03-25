##################################################################
##
## CLUSTER TREE
## by erucic acid content
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################
# load library
library(readxl)
library(stringr)

# load data
acid <- read_xlsx("Erucic_Acid.xlsx")

acid$erucic_acid <-str_replace_na(replacement = "NA", string = acid$erucic_acid)

# keep one set with 0 instead of NA
acid$erucic_acid <-str_replace_na(replacement = "0", string = acid$erucic_acid)

# remove NA
clean.acid <- subset(acid, !acid$erucic_acid == "NA")

# list of removed Taxa
removed <- subset(acid, acid$erucic_acid == "NA")

##################################################################
##
## PLOTTING
##
##################################################################

# investigating acid content
clean.acid$erucic_acid <- as.numeric(clean.acid$erucic_acid)
## summary(clean.acid$erucic_acid)
## sd(clean.acid$erucic_acid)

# get lower and upper 20
min <- subset(clean.acid, clean.acid$erucic_acid < 27)
max <- subset(clean.acid, clean.acid$erucic_acid > 111)

# read fasta file
fasta <- read.phyDat("alignment.fa",
                    format = "fasta", type = "DNA")

# calculate pairwise distances
dm <- dist.logDet(fasta)

# hierarchical clustering
treeUPGMA <- upgma(dm)

# root tree by outgroup
rootedtree <- root(treeUPGMA, outgroup = "ref")

# plot rooted tree
plot.phylo(rootedtree)

t <- ggtree(rootedtree, layout = "circular")+
    geom_tiplab2(aes(label=lab),
                align =t, linetype=NA, size=2, offset=4, hjust=0.5)

gheatmap(t, acid, offset = 10, color=NULL, 
        colnames_position="top", 
        colnames_angle=90, colnames_offset_y = 1, 
        hjust=0, font.size=2)

##################################################################
