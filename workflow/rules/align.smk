if config["species"] == "human":
    rule bwa_mem_human:
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
    rule bwa_mem_mouse:
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

    rule samtools_get_unmapped: 
        output: 
            "results/align/{sample}.unmapped.bam",
        input:
            bam="results/align/{sample}.sorted.bam",
            bai="results/align/{sample}.sorted.bam.bai",
        log:
            "logs/align/{sample}.unmap.log"
        threads: config["samtools"]["threads"]
        params:
            extra="-b -f 4",
        wrapper:
            "v4.6.0/bio/samtools/view"

    rule samtools_convert_to_fastq:
        output: 
            temp("results/align/{sample}.unmapped.1.fq"),
            temp("results/align/{sample}.unmapped.2.fq"),
        input:
            unbam="results/align/{sample}.unmapped.bam",
        log:
            "logs/align/{sample}.unmap.fq.log",
        threads: config["samtools"]["threads"]
        params:
        wrapper:
            "v4.6.0/bio/samtools/fastq/separate"

    rule bwa_mem_unmapped:
        output:
            bam="results/align/{sample}.unmapped.realigned.sorted.bam",
        input:
            idx=config["ref"],
            reads=["results/align/{sample}.unmapped.1.fq", "results/align/{sample}.unmapped.2.fq"],
        log:
            "logs/align/{sample}.unmap.realign.log",
        threads: config["bwa"]["threads"]
        params:
            extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
            sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
            sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
            sort_extra="",  # Extra args for samtools/picard sorts.
        wrapper:
            "v3.13.8/bio/bwa-mem2/mem"

    rule samtools_calculate_depth:
        output:
            "results/align/{sample}.depth.txt",
        input: 
            bams="results/align/{sample}.unmapped.realigned.sorted.bam",
        log:
            "logs/align/{sample}.depth.log"
        threads: config["samtools"]["threads"]
        wrapper:
            "v4.6.0/bio/samtools/depth"
