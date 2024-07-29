rule dup_ref:
    output:
        bam="results/dedup/{sample}.merged.mtref.mkdups.bam",
        metrics="results/dedup/{sample}.merged.mtref.mkdups.metrics.txt"
    input:
        bams="results/align/{sample}.merged.mtref.bam"
    log:
        "logs/align/{sample}.ref.mkdups.log"
    threads: config["picard"]["threads"]
    params:
        extra="--VALIDATION_STRINGENCY SILENT --CREATE_INDEX true --OPTICAL_DUPLICATE_PIXEL_DISTANCE 2500 --ASSUME_SORT_ORDER queryname --CLEAR_DT false --ADD_PG_TAG_TO_READS false"
    resources:
        mem_mb=config["picard"]["mem_mb"]
    wrapper:
        "v3.13.8/bio/picard/markduplicates"

