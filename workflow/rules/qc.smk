rule qc_fastqc:
    output:
        html="results/qc/fastqc/{read}_fastqc.html",
        zip="results/qc/fastqc/{read}_fastqc.zip",
    input:
        lambda wildcards: f"{config['fastq_dir']}/{wildcards.read}.fastq.gz"
    threads: config["fastqc"]["threads"]
    log:
        "logs/qc/{read}.fastqc.log",
    resources:
        mem_mb=config["fastqc"]["mem_mb"],
    wrapper:
        "v3.13.8/bio/fastqc"
