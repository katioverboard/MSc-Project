##################################################################
##
## Evaluation of cluster tools
##
##################################################################

##################################################################
##
## SET UP
##
##################################################################

# load packages
library(msa)
library(Biostrings)
library(seqinr)
library(ape)
library(ade4)
library(adegenet)
library(phangorn)
library(ggplot2)
library(ggtree)
library(stats)

library(fastcluster)
library(flashClust)
library(phyclust)
library(phylotools)

library(bios2mds)
library(rhierbaps)

library(SNPRelate)

##################################################################
## phangorn
## works!

# read fasta file
fasta <- read.phyDat("clean.fa",
                    format = "fasta", type = "DNA")

# calculate pairwise distances
## compute pairwise distances
# dist.ml
dm <- dist.logDet(fasta)

# hierarchical clustering
treeUPGMA <- upgma(dm)

# root tree by outgroup
rootedtree <- root(treeUPGMA, outgroup = "ref + Cluster 104")

# plot rooted tree
plot.phylo(rootedtree)


# use ggtree 

ggtree(rootedtree, branch.length = "None", aes(color=node))+
    geom_tiplab()+
    theme_dendrogram()

##################################################################
## ape
## not sensitive enough
## although log dist shows values
## they are the same

dna <- read.dna(file = "clean.fa", format = "fasta")

# calulate distance
D <- dist.dna(dna, model = "logdet", variance = T)

##logdet: The Log-Det distance, developed by Lockhart et al. (1994),
## is related to BH87. However, this distance is symmetric.
## Formulae from Gu and Li (1996) are used.
## dist.logdet in phangorn uses a different implementation that
## gives substantially different distances for low-diverging sequences.

#### all values are the same 

# build trees
tre <- nj(D)

plot(tre, cex = 0.6, show.tip=T)

##################################################################

### SNPRelate

## only for VCF Files
## cant convert FASTA to GDS

##################################################################
## dist.alignment / seqinr
## not sensitive enough

dna2 <- read.alignment("clean.fa", format = "fasta")

d <- dist.alignment(dna2, "identity")

d <- as.matrix(d)

nj <- nj(d)

plot(nj)

##################################################################
## hierBAPS
## not working
## all sites are conserved
## not sensitive enough?

dna3 <- read.dna("clean.fa")
# create matrix
matrix <- load_fasta(dna3)

# run hierBAPS
results <- hierBAPS(matrix)

##################################################################

### adegenet
## not supported on windows?
## does not work on viking

gen <- fasta2genlight("clean.fa")

##################################################################

## msa
## alignment not needed?

dna4 <- readDNAStringSet("clean.fa")
msa(dna4)

##################################################################