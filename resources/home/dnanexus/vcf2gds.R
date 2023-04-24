#!/usr/bin/env Rscript

# SET LIBARY PATH
.libPaths('/home/dnanexus/R/x86_64-pc-linux-gnu-library/3.6')

# LOAD REQUIRED LIBRARIES
library(SeqVarTools)
library(gdsfmt)
library(SeqArray)

# Get user arguments
args = commandArgs(trailingOnly=TRUE)
vcf=args[1]
gds=args[2]
pN=as.integer(args[3])

### Perform the conversion
seqVCF2GDS(vcf, gds, verbose=FALSE, parallel=pN, storage.option="LZMA_RA")


### Now we need to inject "PASS" into every entry for variants to be analysed from here:

# Open the GDS for writing
genofile<-seqOpen(gds, readonly = FALSE)

# extract and assign annotation data to Anno.folder (gdsfmt)
Anno.folder <- index.gdsn(genofile, "annotation/info")

# Add a new GDS node to the GDS file. (gdsfmt)
# generate vector we can use to count variants to apply function through rep
position <- as.integer(seqGetData(genofile, "position"))
add.gdsn(Anno.folder, "QC_label", val=factor(rep("PASS", length(position))), compress="LZMA_ra", closezip=TRUE)

# close the GDS
seqClose(genofile)

