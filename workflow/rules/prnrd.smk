rule prnrds:
    output:
        bam="results/align/{sample}.mito.sorted.bam",
    input:
        bam="results/align/{sample}.sorted.bam",
        bai="results/align/{sample}.sorted.bam.bai",
        ref=config["ref"],
        dict=config["dict"],
    log:
        "logs/align/{sample}.prnrd.log",
    container:
        config["gatk"]["container"]
    params:
        chrom=config["mt_chrom_name"],
    threads: config["gatk"]["threads"]
    shell:
        """
        gatk PrintReads \
        -L {params.chrom} \
        --read-filter MateOnSameContigOrNoMappedMateReadFilter \
        --read-filter MateUnmappedAndUnmappedReadFilter \
        -I {input.bam} \
        -O {output.bam}
        """
