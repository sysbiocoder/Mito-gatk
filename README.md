# Mito-gatk

A snakemake workflow for mitochondrial short variant analysis using [GATK Best Practices](https://gatk.broadinstitute.org/hc/en-us/articles/4403870837275-Mitochondrial-short-variant-discovery-SNVs-Indels)

## Set up the workflow

### Clone the github repository

```
git clone https://github.com/sysbiocoder/Mito-gatk.git
cd Mito-gatk
git checkout dev
```

### Create resources and singularity directories

Run `mkdir resources` and copy/link the reference files


Run `mkdir singularity` and copy the singularity image files for GATK, Picard and VEP.

### Download and install haplochecker

```
cd Mito-gatk
mkdir haplocheck
wget https://github.com/genepi/haplocheck/releases/download/v1.3.2/haplocheck.zip
unzip haplocheck.zip
```

### Download VEP database

Download the needed VEP cache using the [Ensemble FTP](https://ftp.ensembl.org/pub/current_variation/indexed_vep_cache/) and store in a directory in `resources/vep/cache`. Keep the subdirectory structure as is. 

## Run the pipeline

`snakemake -s workflow/Snakefile --software-deployment-method conda apptainer`
