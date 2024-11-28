rule annotate_variants:
    output:
        calls="results/variants/{sample}.filtered.annotated.vcf",  # .vcf, .vcf.gz or .bcf
    input:
        calls="results/variants/{sample}.merged.combined.filtered.excluded.vcf",  # .vcf, .vcf.gz or .bcf
    log:
        "logs/vep/{sample}.annotate.log",
    threads: config["vep"]["threads"]
    container:
        config["vep"]["container"]
    shell:
        """
            vep \
            --dir_cache /opt/vep/.vep \
            -i {input.calls} \
            -o {output.calls} \
            --offline --pick --force_overwrite --species mus_musculus \
            --assembly GRCm39 --cache 
        """
