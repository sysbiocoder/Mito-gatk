rule revertfq:
    output:
        fastq1="results/align/{sample}.mito.reverted_1.fq",
        fastq2="results/align/{sample}.mito.reverted_2.fq"
    input:
        bam="results/align/{sample}.mito.reverted.bam"
    log: "logs/{sample}.revertfq.log"
    threads: config["picard"]["threads"]
    resources: 
        mem_mb=config["picard"]["mem_mb"]
    wrapper:
        "v3.13.8/bio/picard/samtofastq"

