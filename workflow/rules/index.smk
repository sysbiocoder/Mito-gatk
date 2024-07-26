rule samtools_index:
    input:
        bam = "results/align/{sample}.bam"
    output:
        bai = "results/align/{sample}.bam.bai"
    log:
        "logs/index/{sample}.log"
    threads: config["samtools"]["threads"]
    wrapper:
        "v3.13.8/bio/samtools/index"
