rule samtools_index:
    input:
        bam = lambda wildcards: expand("{path}/{sample}.{ext}.bam", path=wildcards.path, sample=wildcards.sample, ext=wildcards.ext)
    output:
        bai = "{path}/{sample}.{ext}.bam.bai"
    log:
        "logs/{path}/{sample}.{ext}.log"
    threads: config["samtools"]["threads"]
    wrapper:
        "v3.13.8/bio/samtools/index"