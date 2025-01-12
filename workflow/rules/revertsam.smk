rule revert:
    output:
        bam="results/align/{sample}.mito.reverted.bam",
    input:
        bam="results/align/{sample}.mito.sorted.bam",
    log:
        "logs/align/{sample}.revert.log",
    threads: config["picard"]["threads"]
    params:
        extra="--OUTPUT_BY_READGROUP false --VALIDATION_STRINGENCY LENIENT --ATTRIBUTE_TO_CLEAR FT --ATTRIBUTE_TO_CLEAR CO --SORT_ORDER queryname --RESTORE_ORIGINAL_QUALITIES false",
    resources:
        mem_mb=config["picard"]["mem_mb"],
    wrapper:
        "v4.7.2/bio/picard/revertsam"
