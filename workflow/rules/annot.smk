
"""
rule snpeff_download:
    output:
        config["snpeff"]["db"]
    log:
        "logs/snpeff/download.log"
    params:
        reference=config["snpeff"]["ref"]
    resources:
        mem_mb=config["snpeff"]["mem_mb_download"]
    wrapper:
        "v3.13.8/bio/variants/download"


rule snpeff_annotate:
    input:
        calls="results/variants/{sample}.merged.combined.filtered.excluded.vcf", 
        db=config["snpeff"]["db"] 
    output:
        calls="results/variants/{sample}.annotated.vcf",   # annotated calls (vcf, bcf, or vcf.gz)
        stats="results/variants/{sample}.annotated.html",  # summary statistics (in HTML), optional
        csvstats="results/variants/{sample}.annotated.csv" # summary statistics in CSV, optional
    log:
        "logs/variants/{sample}.annotate.log"
    resources:
        java_opts=config["snpeff"]["java_opts"],
        mem_mb=config["snpeff"]["mem_mb_anno"]
    wrapper:
        "v3.13.8/bio/snpeff/annotate"
"""


