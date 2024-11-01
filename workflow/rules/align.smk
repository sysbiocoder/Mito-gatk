if config["species"] == "human": 
    rule bwa_mem:
        output:
            bam="results/align/{sample}.sorted.bam",
        input:
            idx=config["ref"],
            reads=lambda wildcards: get_reads(wildcards),
        log:
            "logs/align/{sample}.log",
        threads: config["bwa"]["threads"]
        params:
            extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
            sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
            sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
            sort_extra="",  # Extra args for samtools/picard sorts.
        wrapper:
            "v3.13.8/bio/bwa-mem2/mem"
elif config["species"] == "mouse": 
    rule bwa_mem:
        output:
            bam="results/align/{sample}.sorted.bam",
        input:
            idx=config["mt_ref"],
            reads=lambda wildcards: get_reads(wildcards),
        log:
            "logs/align/{sample}.log",
        threads: config["bwa"]["threads"]
        params:
            extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
            sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
            sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
            sort_extra="",  # Extra args for samtools/picard sorts.
        wrapper:
            "v3.13.8/bio/bwa-mem2/mem"

