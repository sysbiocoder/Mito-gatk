rule samtools_index:
    input:
        bam = "{path}/{sample}.{ext}.bam"
    output:
        bai = "{path}/{sample}.{ext}.bam.bai"
    log:
        "logs/{path}/{sample}.{ext}.log"
    threads: config["samtools"]["threads"]
    wrapper:
        "v3.13.8/bio/samtools/index"