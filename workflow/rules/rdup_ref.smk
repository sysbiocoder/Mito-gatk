rule dup_ref:
    output:
        bam="results/dedup/{sample}_merged_mtref_mkdups.bam",
        metrics="results/dedup/{sample}_merged_mtref_mkdups_metrics.txt"
    input:
        bam="results/align/{sample}_merged_mtref.bam"
    log:
        "logs/{sample}.ref.mkdups.log"
    threads: config["picard"]["threads"]
    params:
        extra="--VALIDATION_STRINGENCY=SILENT --CREATE_INDEX=true --OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 --ASSUME_SORT_ORDER=queryname --CLEAR_DT=false --ADD_PG_TAG_TO_READS=false"
    resources:
        mem_mb=config["picard"]["mem_mb"]
    wrapper:
        "v3.13.8/bio/picard/markduplicates"

