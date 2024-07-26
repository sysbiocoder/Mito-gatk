
rule qc_fastqc:
    output:
        html="results/qc/fastqc/{read}_fastqc.html",
        zip="results/qc/fastqc/{read}_fastqc.zip"
    input:
        ".test/data/raw/{read}.fastq.gz"
    #conda:
    #    "../envs/fastqc.yaml"
    threads: 
        config["fastqc"]["threads"]
    resources: 
        mem_mb=config["fastqc"]["mem_mb"]
    wrapper:
        "v3.13.8/bio/fastqc"
    #shell:
    #    """
    #    fastqc --threads {threads} {input} --outdir=results/qc/fastqc
    #    """