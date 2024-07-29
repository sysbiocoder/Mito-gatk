rule bwa_refmt:
    input:
        idx=config["mt_ref"],
        reads=["results/align/{sample}.mito.reverted_1.fq","results/align/{sample}.mito.reverted_2.fq"]
    output:
        out="results/align/{sample}.mt.ref.bam"
    log:
        "logs/align/{sample}.mt.ref.log"
    threads: config["bwa"]["threads"]
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
        sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
    wrapper:
        "v3.13.8/bio/bwa-mem2/mem"



