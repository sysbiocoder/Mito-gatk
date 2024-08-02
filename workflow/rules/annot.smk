rule annotate_variants:
    input:
        calls="results/variants/{sample}.merged.combined.filtered.excluded.vcf",  # .vcf, .vcf.gz or .bcf
        #cache="resources/vep/cache",  # can be omitted if fasta and gff are specified
    output:
        calls="{sample}.filtered.annotated.vcf",  # .vcf, .vcf.gz or .bcf
    log:
        "logs/vep/{sample}.annotate.log"
    threads:
        config["vep"]["threads"]
    container: config["vep"]["container"]
    shell:
        """
            vep \
            --dir_cache /opt/vep/.vep \
            -i {input.calls} \
            -o {output.calls} \
            --offline --species mus_musculus \
            --assembly GRCm39 --cache
        """