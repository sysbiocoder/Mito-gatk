rule bwa_refmt:
    input:
        idx=config["mt_ref"],
        fq1="results/align/{sample}.mito.reverted_1.fq",
        fq2="results/align/{sample}.mito.reverted_2.fq"
    output:
        out="results/align/{sample}_mt_ref.bam"
    #params:
    #  	rg=lambda wildcards: f"@RG\\tID:{wildcards.sample}\\tPU:{reads.loc[wildcards.sample, 'PU'].values[0]}\\tSM:{wildcards.sample}\\tPL:ILLUMINA\\tLB:{reads.loc[wildcards.sample, 'unit'].values[0]}"  
    log:
        "logs/{sample}_mt_ref.log"
    threads: config["bwa"]["threads"]
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
        sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
        sort_extra="",  # Extra args for samtools/picard sorts.
    #conda:
    #    "../envs/bwa.yaml"
    wrapper:
        "v3.13.8/bio/bwa-mem2/mem"
    #shell:
    #    """
    #    bwa mem -M -t {threads} -R '{params.rg}' {input.idx} {input.fq1} {input.fq2} | \
    #    samtools view -@ {threads} -Sb - | \
    #    samtools sort -@ {threads} -o {output.out}
    #    samtools index -@ {threads} {output.out}
    #    """



