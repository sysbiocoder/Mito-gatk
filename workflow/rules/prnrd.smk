rule prnrds:
    output:
        bam="results/align/{sample}.mito.sorted.bam" 
    input:
        bam="results/align/{sample}.sorted.bam",
    log:
        "logs/align/{sample}.prnrd.log"
    #container: "docker://broadinstitute/gatk"
    #config["gatk"]["sif"]
    params:
        chrom=config["mt_chrom_name"]
        spark_extra="--intervals {params.chrom} --read-filter MateOnSameContigOrNoMappedMateReadFilter --read-filter MateUnmappedAndUnmappedReadFilter" 
    threads: config["gatk"]["threads"]
    wrapper: "v3.13.8/bio/gatk/printreadsspark"
    #shell:
    #    """
    #    gatk PrintReads \
    #        -L {params.chrom} \
    #        --read-filter MateOnSameContigOrNoMappedMateReadFilter \
    #        --read-filter MateUnmappedAndUnmappedReadFilter \
    #        -I {input.bam} \
    #        -O {output.bam} \
    #        2> {log}
    #    """