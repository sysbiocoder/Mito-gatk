##############################
# inputfunctions.smk
#
# Collection of helper functions for the workflow
##############################

# Function to generate list of all FastQC zip files
def all_qc_fastqc(wildcards):
    fn = "results/qc/fastqc/{}_fastqc.zip"
    # Extract the file names from the full paths in reads.tsv
    files = [fn.format(os.path.basename(x).replace(".fastq.gz", "")) for x in reads.reads.values]
    return files


# Function to collect all QC-related tasks
def all_qc(wildcards):
    d = {
        "fastqc_zip": all_qc_fastqc(wildcards),
    }
    return d

# Function to collect all tasks
def all(wildcards):
    d = {}
    d.update(**all_qc(wildcards))
    return d
