rule merge_mtshift_ref:
    output:
        vcf="results/variants/{sample}.merged.combined.vcf"
    input:
        vcfs=["results/variants/{sample}.merged.mtref.mkdups.vcf","results/variants/{sample}.merged.lift.vcf"]
    threads:
        config["picard"]["threads"]
    resources:
        mem_mb=config["picard"]["mem_mb"]
    log:
        "logs/picard/{sample}.mergevcfs.log"
    wrapper:
        "v3.13.8/bio/picard/mergevcfs"

rule py_combine_stats:
    output:
        "results/variants/{sample}.merged.combined.vcf.stats"
    input:
        stat1="results/variants/{sample}.merged.mtref.mkdups.vcf.stats",
        stat2="results/variants/{sample}.merged.mtshft.mkdups.vcf.stats"
    threads:
        config["picard"]["threads"]
    resources:
        mem_mb=config["picard"]["mem_mb"]
    log:
        "logs/picard/{sample}.mergevcfs.log"
    shell: """ python workflow/scripts/combstats.py -r {input.stat1} -s {input.stat2} -o {output}  """