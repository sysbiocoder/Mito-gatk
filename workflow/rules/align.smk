
rule bwa_mem:
    output:
        bam="results/align/{sample}.sorted.bam",
        bai="results/align/{sample}.sorted.bam.bai"
    input:
        idx=config["ref"],
        reads=lambda wildcards: get_reads(wildcards)
    log:
        "logs/align/{sample}.log"
    params:
        rg=lambda wildcards: f"@RG\\tID:{wildcards.sample}\\tPU:{reads.loc[wildcards.sample, 'PU'].values[0]}\\tSM:{wildcards.sample}\\tPL:ILLUMINA\\tLB:{reads.loc[wildcards.sample, 'unit'].values[0]}"    
    threads: config["bwa"]["threads"]
    conda: 
        "../envs/bwa.yaml"
    shell:
            """
            bwa mem -M -t {threads} -R '{params.rg}' {input.idx} {input.reads[0]} {input.reads[1]} | \
            samtools view -@ {threads} -Sb - | \
            samtools sort -@ {threads} - -o {output.bam}
            samtools index -@ {threads} {output.bam} 2> {log}
            """