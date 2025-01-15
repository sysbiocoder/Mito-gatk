rule filter_mutect_calls:
    output:
        "results/variants/{sample}.merged.combined.filtered.vcf",
    input:
        vcf="results/variants/{sample}.merged.combined.vcf",
        ref=config["mt_ref"],
        cont="results/haplocheck/{sample}/contamination/contamination.raw.txt",
        stats="results/variants/{sample}.merged.combined.vcf.stats",
    log:
        "logs/gatk/{sample}.filter.vcf.log",
    threads: config["gatk"]["threads"]
    resources:
        mem_mb=config["gatk"]["mem_mb"],
    params:
        min_AF=config["filter"]["minAF"],
        min_reads_per_strand=config["filter"]["min_reads_per_strand"]
    container:
        config["gatk"]["container"]
    shell:
        """
        gatk FilterMutectCalls \
        -V {input.vcf} \
        -R {input.ref} \
        -O {output} \
        --stats {input.stats} \
        --mitochondria-mode \
        --min-allele-fraction {params.min_AF} \
        --min-reads-per-strand {params.min_reads_per_strand}
        """
