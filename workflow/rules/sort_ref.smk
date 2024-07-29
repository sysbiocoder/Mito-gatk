rule samtools_sort_ref:
    input:
        bam = "results/dedup/{sample}.merged.mtref.mkdups.bam"
    output:
        bai = "results/dedup/{sample}.merged.mtref.mkdups.sorted.bam"
    log:
        "logs/align/{sample}.ref.mkdups.sort.log"
    threads: config["samtools"]["threads"]
    wrapper:
        "v3.13.8/bio/samtools/sort"