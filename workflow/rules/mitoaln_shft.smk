rule bwa_shftmt:
    input:
        idx=config["mt_shft_ref"],
        reads=["results/align/{sample}.mito.reverted_1.fq","results/align/{sample}.mito.reverted_2.fq"]
    output:
        out="results/align/{sample}.mt.shft.bam"
    log:
        "logs/align/{sample}.mt.shft.log"
    threads: config["bwa"]["threads"]
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
        sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
    wrapper:
        "v3.13.8/bio/bwa-mem2/mem"
