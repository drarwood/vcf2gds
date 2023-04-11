#!/bin/bash
# vcf2gds 0.0.1
# Andrew R Wood
# University of Exeter
# No warrenty provided!
# App will run on a single machine from beginning to end.

main() {

    echo "Input VCF: vcf_file: '$vcf_file'"
    echo "Output GDS: gds_filename: '$gds_filename'"

    # Download the VCF to convert to GDS
    dx download "$vcf_file" -o vcf_file

    # Unpack the R library
    tar -zxf r_library.tar.gz

    # Run the R script to 1) convert VCF to GDS, 2) inject PASS as a QC filter
    Rscript vcf2gds.R vcf_file gds

    # Upload the GDS file to the project directory
    gds=$(dx upload gds --brief --path ./$gds_filename)
    dx-jobutil-add-output gds "$gds" --class=file

}
