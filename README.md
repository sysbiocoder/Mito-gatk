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

Run `mkdir resources` and link the reference files


Run `mkdir singularity` and link the singularity containers for GATK, Picard and VEP.

(All files can be found in `/medstore/projects/P22-005/Kristina/Mito-gatk`)

### Download and install haplochecker

```
cd Mito-gatk
mkdir haplocheck
wget https://github.com/genepi/haplocheck/releases/download/v1.3.2/haplocheck.zip
unzip haplocheck.zip
```

### Download VEP database from Ensembl

Download the needed VEP cache using the [Ensembl FTP](https://ftp.ensembl.org/pub/current_variation/indexed_vep_cache/) and store in a directory in `resources/vep/cache`. Keep the subdirectory structure as is. 

### Create sample and reads file

The workflow parses two files, 1) samples.tsv containing sample information and 2) reads.tsv containing read and sequencing information. The files need to have the same columns as the example files below.   

The path to these are set in config.yaml

Example samples.tsv:
```
sample	population
E-2843_Liver	polg_wt_mtDNA
E-2843_Liver_pcr	polg_wt_lrPCR 
T-2767_Liver	polg_ko_mtDNA
T-2767_Liver_pcr	polg_ko_lrPCR
```

Example reads.tsv:
```
unit	sample	reads	id	PU
210507_TESTSTEST	E-2843_Liver	data/raw/SRR21601404_1.fastq.gz	1	TESTSTEST 
210507_TESTSTEST	E-2843_Liver	data/raw/SRR21601404_2.fastq.gz	2	TESTSTEST
210507_TESTSTEST	E-2843_Liver_pcr	data/raw/SRR21601420_1.fastq.gz	1	TESTSTEST
210507_TESTSTEST	E-2843_Liver_pcr	data/raw/SRR21601420_2.fastq.gz	2	TESTSTEST
210507_TESTSTEST	T-2767_Liver	data/raw/SRR21601450_1.fastq.gz	1	TESTSTEST 
210507_TESTSTEST	T-2767_Liver	data/raw/SRR21601450_2.fastq.gz	2	TESTSTEST
210507_TESTSTEST	T-2767_Liver_pcr	data/raw/SRR21601416_1.fastq.gz	1	TESTSTEST 
210507_TESTSTEST	T-2767_Liver_pcr	data/raw/SRR21601416_2.fastq.gz	2	TESTSTEST  
```

## Run the workflow

The most basic way to run the pipeline (in an interactive session for instance) is:

`snakemake -s workflow/Snakefile --software-deployment-method conda apptainer`

To submit jobs to a cluster run it with the `--profile` flag. Download a profile from [Snakemake-Profiles](https://github.com/Snakemake-Profiles) or configure one yourself in `~/.config/snakemake/<profile_name>`. 

A simple example, adding a file called `config.yaml` to `~/.config/snakemake/sge`. It can look something like the file below.

```
executor: "cluster-generic"
cluster-generic-submit-cmd: "qsub -N {rule} -q <name>.q -pe mpi {threads} -V -cwd -o logs/{rule}.{jobid}.out -e logs/{rule}.{jobid}.err"
jobs: 1000
latency-wait: 60
rerun-incomplete: true
restart-times: 1
```

Then running the pipeline with:

`snakemake -s workflow/Snakefile --software-deployment-method conda apptainer --profile sge`
 

### Annotation

OBS! (I will fix this) Currently the VEP container need to have two --bind arguments set when running the workflow, and therefore it can only be run separately after the other parts are done. Line 46 in `Snakefile` and line 226 in `inputfunctions.smk` need to be uncommented. Annotation with VEP can then be run with: 
 
`snakemake -s workflow/Snakefile --software-deployment-method conda apptainer --apptainer-args "--bind $(pwd)/resources/vep/cache:/opt/vep/.vep --bind $(pwd)/results/variants:/results/variants"`
