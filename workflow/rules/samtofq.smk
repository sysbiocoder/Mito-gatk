rule revertfq:
    output:
        fq1="results/align/{sample}.mito.reverted_1.fq",
        fq2="results/align/{sample}.mito.reverted_2.fq"
    input:
        bam="results/align/{sample}.mito.reverted.bam"
    log: "logs/{sample}.revertfq.log"
    threads: config["picard"]["threads"]
    wrapper:
        "v3.13.8/bio/picard/samtofastq"

