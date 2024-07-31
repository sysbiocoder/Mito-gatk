rule filter_mutect_calls:
    input:
        vcf="results/variants/{sample}.merged.combined.vcf",
        ref=config["mt_ref"],
        cont="results/haplocheck/{sample}/contamination/contamination.raw.txt",
        stats="results/variants/{sample}.merged.combined.vcf.stats"
    output:
        "results/variants/{sample}.merged.combined.filtered.vcf"
    log: "logs/gatk/{sample}.filter.vcf.log"
    resources: 
        mem_mb=config["gatk"]["mem_mb"]
    container: config["gatk"]["container"]
    shell:
        """
        gatk FilterMutectCalls \
        -V {input.vcf} \
        -R {input.ref} \
        -O {output} \
        --stats {input.stats} \
        --max-alt-allele-count 4 \
        --mitochondria-mode 2> {log}
        """
