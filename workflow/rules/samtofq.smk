rule revertfq:
    output:
        fq1="results/align/{sample}.mito.reverted_1.fq",
        fq2="results/align/{sample}.mito.reverted_2.fq"
    input:
        bam="results/align/{sample}.mito.reverted.bam"
    log:
        "logs/{sample}.revertfq.log"
    #conda:
    #    "../envs/picard.yaml"
    threads: config["picard"]["threads"]
    wrapper:
        "v3.13.8/bio/picard/samtofastq""
    #shell:
    #    """
    #    picard SamToFastq \
    #        I={input.bam} \
    #        F={output.fq1} \
    #        F2={output.fq2} \
    #        2> {log}
    #    """
