##################################################################
##
## Combining bundled-scripts into single script
##
##################################################################
# gene list
gene <- c("Cab035983.1", "Bo3g168810.1", "Cab045628.2", "Cab023705.1",
        "Bo1g139590.1", "Bo5g134730.1")

# get types
types <- c("Control", "Radiation")

for(g in 1:length(gene)){
    # get script names
    for(y in 1:length(types)){
    scriptnames <- dir(paste0(gene[g], "/",types[y], "/sh"), pattern=".sh$")
    scripts <- gsub(".sh","", scriptnames)
    
    # write sh file
    for(c in 1:length(scripts)){
        command3 <- paste0("final-submit.sh", sep = "")
        log.file3 <- paste0("submit.log", sep = "")
        cat(paste0("#!/bin/bash\n#SBATCH --job-name=",command3,"\n#SBATCH --mail-type=NONE\n#SBATCH --mail-user=kg913@york.ac.uk\n#SBATCH --ntasks=16\n#SBATCH --mem=10gb\n#SBATCH --time=11:59:00\n#SBATCH --output=",log.file3,"\n#SBATCH --account=biol-pgen-2019\ndate\n"), file=command3)

    # write scripts in sh file
        for (s in 1:length(scripts)){
            cat("module load lang/R\n",
                file = command3, append = T, sep = "")
            cat("qsub ", scripts[s], ".sh\n",
                file = command3, append = T, sep = "")
            cat("Rscript AD-script.R\n",
                file = command3, append = T, sep = "")
            }
        }
    }
}


