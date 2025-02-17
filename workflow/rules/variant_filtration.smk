rule variant_filtration:
    output:
        "results/variants/{sample}.merged.combined.filtered.excluded.vcf",
    input:
        vcf="results/variants/{sample}.merged.combined.filtered.vcf",
        ref=config["mt_ref"],
    container:
        config["gatk"]["container"]
    threads: config["gatk"]["threads"]
    log:
        "logs/gatk/{sample}.variantfilt.log",
    resources:
        mem_mb=config["gatk"]["mem_mb"],
    shell:
        """
        gatk VariantFiltration -V {input.vcf} -R {input.ref} -O {output}
        """
