
rule qc_fastqc:
    input:
        ".test/data/raw/{read}.fastq.gz"
    output:
        html="results/qc/fastqc/{read}_fastqc.html",
        zip="results/qc/fastqc/{read}_fastqc.zip"
    conda:
        "../envs/fastqc.yaml"
    threads: 
        config["fastqc"]["threads"]
    shell:
        """
        fastqc --threads {threads} {input} --outdir=results/qc/fastqc
        """