rule haplochecker_vcf:
    output:
        cont="results/haplocheck/{sample}/contamination/contamination.raw.txt",
    input:
        vcf="results/variants/{sample}.merged.combined.vcf",
    log:
        "logs/haplo/{sample}.haplocheck.log",
    threads: config["gatk"]["threads"]
    shell:
        """haplocheck/haplocheck --out {output} {input.vcf}"""
