rule samtools_sort_shft:
    input:
        bam = "results/dedup/{sample}.merged.mtshft.mkdups.bam"
    output:
        bai = "results/dedup/{sample}.merged.mtshft.mkdups.sorted.bam"
    log:
        "logs/align/{sample}.shft.mkdups.sort.log"
    threads: config["samtools"]["threads"]
    wrapper:
        "v3.13.8/bio/samtools/sort"