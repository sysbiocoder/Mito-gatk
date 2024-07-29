##############################
# inputfunctions.smk
#
# Collection of helper functions for the workflow
##############################
import glob

def all_qc_fastqc(wildcards):
    """Generate list of all FastQC zip files"""
    fn = "results/qc/fastqc/{}_fastqc.zip"
    # Extract the file names from the full paths in reads.tsv
    files = [fn.format(os.path.basename(x).replace(".fastq.gz", "")) for x in reads.reads.values]
    return files

def all_map_index(wildcards):
    """Pseudotarget that collects all BAM files with various extensions in align and dedup directories."""
    
    bam_files = glob.glob("results/align/*.bam") + glob.glob("results/dedup/*.bam")
    bai_files = [bam + ".bai" for bam in bam_files]
    
    return bai_files


# Function to retrieve read1 and read2 files for a sample
def get_reads(wildcards):
    read1 = reads.loc[wildcards.sample].query("id == 1")["reads"].values[0]
    read2 = reads.loc[wildcards.sample].query("id == 2")["reads"].values[0]
    return [read1, read2]

# Function to generate list of all output BAM files
def all_bwa_bam(wildcards):
    fn = "results/align/{}.sorted.bam"
    files = [fn.format(sample) for sample in reads.index]
    #files = [fn.format(os.path.basename(x).replace(".fastq.gz", "")) for x in reads.reads.values]
    return files

# Function to generate list of all output BAM index files
def all_bwa_bai(wildcards):
    fn = "results/align/{}.sorted.bam.bai"
    files = [fn.format(sample) for sample in reads.index]
    #files = [fn.format(os.path.basename(x).replace(".fastq.gz", "")) for x in reads.reads.values]
    return files

def all_prnrds_bam_output(wildcards):
    fn = "results/align/{}.mito.sorted.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_revertsam_bam_output(wildcards):
    fn = "results/align/{}.mito.reverted.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_mitoaln_bam_ref(wildcards):
    fn = "results/align/{}_mt_ref.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_mitoaln_bam_shft(wildcards):
    fn = "results/align/{}_mt_shft.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_merged_bam_ref(wildcards):
    fn = "results/align/{}_merged_mtref.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_merged_bam_shft(wildcards):
    fn = "results/align/{}_merged_mtshft.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def bwa_mem_index_input_ext(wildcards):
    """Retrieve bwa mem index with extensions"""
    return expand(
        "{index}{ext}", index=config["ref"], ext=[".amb", ".ann", ".bwt", ".pac", ".sa"]
    )

def all_samtofq_output(wildcards):
    base_fn = "results/align/{}.mito.reverted_{}.fq"
    return {
        "fq1": [base_fn.format(sample, 1) for sample in reads.index],
        "fq2": [base_fn.format(sample, 2) for sample in reads.index]
    }

def all_rdup_ref(wildcards):
    fn = "results/dedup/{}_merged_mtref_mkdups.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_rdup_shft(wildcards):
    fn = "results/dedup/{}_merged_mtshft_mkdups.bam"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_wgs_metrics_ref(wildcards):
    fn = "results/dedup/{}_merged_mtref_mkdups_wgs_metrics.txt"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_wgs_metrics_shft(wildcards):
    fn = "results/dedup/{}_merged_mtshft_mkdups_wgs_metrics.txt"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_mutect_ref(wildcards):
    fn = "results/variants/{}_merged_mtref_mkdups.vcf"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_mutect_shft(wildcards):
    fn = "results/variants/{}_merged_mtshft_mkdups.vcf"
    files = [fn.format(sample) for sample in reads.index]
    return files

def all_bwa(wildcards):
    d = {
        "bam": all_bwa_bam(wildcards),
        "bai": all_bwa_bai(wildcards),
        "mt_unbam": all_prnrds_bam_output(wildcards),
        "mt_unbam_rev": all_revertsam_bam_output(wildcards),
        #"mt_ref_bam": all_mitoaln_bam_ref(wildcards), 
        #"mt_shft_bam": all_mitoaln_bam_shft(wildcards),
        #"merged_mt_ref": all_merged_bam_ref(wildcards), 
        #"merged_mt_shft": all_merged_bam_shft(wildcards),
        #"merged_mt_ref_mkdups": all_rdup_ref(wildcards),
        #"merged_mt_shft_mkdups": all_rdup_shft(wildcards)

    }
    return d
    
def all_qc(wildcards):
    """Collect all QC-related tasks"""
    d = {
        "fastqc_zip": all_qc_fastqc(wildcards),
        "wgs_metrics_ref": all_wgs_metrics_ref(wildcards),
        "wgs_metrics_shft": all_wgs_metrics_shft(wildcards)
    }
    return d

def all_vcfs(wildcards):
    """Collect all VCFs"""
    d = {
        "mutect_ref": all_mutect_ref(wildcards),
        "mutect_shft": all_mutect_shft(wildcards)
    }
    return d

def all(wildcards):
    """Collect all tasks"""
    d = {}
    d = {"idx": all_map_index(wildcards)}
    #d.update(**all_qc(wildcards))
    d.update(**all_bwa(wildcards))
    d.update(**all_samtofq_output(wildcards))
    #d.update(**all_vcfs(wildcards))
    return d
