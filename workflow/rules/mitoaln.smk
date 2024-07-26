rule bwa_refmt:
    input:
        idx=config["mt_ref"],
        fq1="results/align/{sample}.mito.reverted_1.fq",
        fq2="results/align/{sample}.mito.reverted_2.fq"
    output:
        out="results/align/{sample}_mt_ref.bam"
    log:
        "logs/{sample}_mt_ref.log"
    threads: config["bwa"]["threads"]
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
        sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
        sort_extra="",  # Extra args for samtools/picard sorts.
    wrapper:
        "v3.13.8/bio/bwa-mem2/mem"



