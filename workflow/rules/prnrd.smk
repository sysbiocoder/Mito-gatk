rule prnrds:
    output:
        bam="results/align/{sample}.mito.sorted.bam" 
    input:
        bam="results/align/{sample}.sorted.bam",
        ref=config["ref"],
        dict=config["dict"]
    log:
        "logs/align/{sample}.prnrd.log"
    params:
        chrom=config["mt_chrom_name"],
        spark_extra="--intervals {params.chrom} --read-filter MateOnSameContigOrNoMappedMateReadFilter --read-filter MateUnmappedAndUnmappedReadFilter" 
    threads: config["gatk"]["threads"]
    wrapper: "v2.3.0/bio/gatk/printreadsspark"
