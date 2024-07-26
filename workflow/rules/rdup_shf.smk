rule dup_shft:
    output:
        bam="result/dedup/{sample}_merged_mtshft_mkdups.bam",
        metrics="result/dedup/{sample}_merged_mtshft_mkdups_metrics.txt"
    input:
        bam="result/align/{sample}_merged_mtshft.bam"
    log:
        "logs/{sample}.shft.mkdups.log"
    threads: config["picard"]["threads"]
    params:
        extra="--VALIDATION_STRINGENCY=SILENT --CREATE_INDEX=true --OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 --ASSUME_SORT_ORDER=queryname --CLEAR_DT=false --ADD_PG_TAG_TO_READS=false"
    resources:
        mem_mb=config["picard"]["mem_mb"]
    wrapper:
        "v3.13.8/bio/picard/markduplicates"
