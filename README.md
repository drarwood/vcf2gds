# VCF to GDS Converter for UK Biobank RAP
#### Developed by Andrew Wood. University of Exeter
This applet converts a VCF to a GDS for subsequent use 
(e.g. [STAAR annotations](https://github.com/xihaoli/favorannotator-rap) / [STAARpipeline](https://github.com/xihaoli/staarpipeline-rap)). 
This app does not perform annotations itself - it is merely a data format converter. This applet depends on the `SeqVarTools`, `gdsfmt`, and the `SeqArray` R libraries. To save dependency install time this applet comes with an R library that will be unpacked during runtime and should be visible on the DNAnexus worker.

---
### Obtaining and installing the applet

Clone this github repo to a local directory:
```
git clone https://github.com/drarwood/vcf2gds
```

Navigate to a relevant directory within the project directory on the DNAnexus platform to install the applet
```
dx cd /path/to/install/apps 
```

Now you are ready to build and upload the applet to the DNAnexus plaform directory:
```
dx build -f vcf2gds
```
---
### Command line usage
Navigate to the RAP directory where you want the output to be directed:
```
dx cd /path/to/where/the/output/should/go
```
Simply run the applet by specifying the name (and path if required) of the `*.vcf.gz` input VCF and the filename of the output GDS.
Note priority is set to high below which is recommended for long processes to avoid jobs potentially being reset when running as normal priority jobs:
```
dx run /path/to/install/apps/vcf2gds \
  -ivcf_file=/path/to/vcf/file/to/convert/my.vcf.gz \
  -igds_filename=my.gds \
  --priority high \
  -y
```

The default worker set for this app is `mem1_ssd1_v2_x36` with 30 parallel processes. 
We note that higher memory instance types are required when processing the UKB 200K WGS
where all INFO fields have been kept. If you run into memory issues, we suggest either reducing
the number of parallel processes used for data conversion or use an instance type with more memory.
To set the number of parallel processes, add the `iparallel` option as follows:
```
dx run /path/to/install/apps/vcf2gds \
    -ivcf_file=/path/to/vcf/file/to/convert/my.vcf.gz \
    -igds_filename=my.gds \
    -iparallel=30 \
    --priority high \
    -y
```
