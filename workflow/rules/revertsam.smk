rule revert:
    output:
        bam="results/align/{sample}.mito.reverted.bam"
    #    bai="results/align/{sample}.mito.reverted.bam.bai"
    input:
        bam="results/align/{sample}.mito.sorted.bam"
    log:
        "logs/{sample}.revert.log"
    #conda:
    #    "../envs/picard.yaml"
    threads: config["picard"]["threads"]
    params:
        extra="--OUTPUT_BY_READGROUP=false --VALIDATION_STRINGENCY=LENIENT --ATTRIBUTE_TO_CLEAR=FT --ATTRIBUTE_TO_CLEAR=CO --SORT_ORDER=querynam RESTORE_ORIGINAL_QUALITIES=false"
    resources:
        mem_mb=config["picard"]["mem_mb"]
    wrapper:
        "v3.13.8/bio/picard/revertsam"
    #shell:
    #    """
    #    picard RevertSam \
    #        I={input.bam} \
    #        O={output.bam} \
    #        OUTPUT_BY_READGROUP=false \
    #        VALIDATION_STRINGENCY=LENIENT \
    #        ATTRIBUTE_TO_CLEAR=FT \
    #        ATTRIBUTE_TO_CLEAR=CO \
    #        SORT_ORDER=queryname \
    #        RESTORE_ORIGINAL_QUALITIES=false \
    #        2> {log}
    #
    #   samtools index -@ {threads} {output.bam} {output.bai}
    #    """
