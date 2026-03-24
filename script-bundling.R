##################################################################
##
## Bundling .sh files into a single script
## for the respective gene
##
##################################################################
# note: if old script is present
# submit-script.sh needs to be temporarily moved to ID/sh folder
# because queuing "outside" the folder is not possible
# hence why directories from ID/sh folder

# directory: mnt/lustre/groups/biol-pgen-2019/kg913/Brassica/scripts

# get gene ID
args <- commandArgs(T)
cat(args, sep = "\n")
ID <- args[1] # ID = gene ID (eg. Cab020592.1)

# get .sh files
filenames <- dir(paste0(ID, "/sh"), pattern=".sh$")
scripts <- gsub(".sh","", filenames)

# bundle scripts
for (i in 1:length(scripts)){
    sh.file <- paste("bundled-script.sh", sep="")
    log.file <- paste("../log/submit-script.log", sep = "")
    cat(paste0("#!/bin/bash\n#SBATCH --job-name=",sh.file,"\n#SBATCH --mail-type=NONE\n#SBATCH --mail-user=kg913@york.ac.uk\n#SBATCH --ntasks=16\n#SBATCH --mem=10gb\n#SBATCH --time=11:59:00\n#SBATCH --output=",log.file,"\n#SBATCH --account=biol-pgen-2019\ndate\n"), file=command1)
# run scripts
for (s in 1:length(scripts)){
    log.file.s <- paste("../log/",scripts[s], ".log", sep = "")
    cat("qsub ", scripts[s], ".sh\n",
        file = sh.file, append = T, sep = "")}
}

##################################################################