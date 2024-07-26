rule collect_wgs_metrics_shft:
    output:
        metrics="results/dedup/{sample}_merged_mtshft_mkdups_wgs_metrics.txt"
    input:
        bam="results/dedup/{sample}_merged_mtshft_mkdups.bam",
        fasta=config["mt_shft_ref"]
    container: config["picard"]["container"]
    log:
        "logs/{sample}.wgs.metrics.shft.log"
    threads: config["picard"]["threads"]
    resources:
        mem_mb=config["picard"]["mem_mb"]
    shell:
        """
        picard CollectWgsMetrics \
            I={input.bam} \
            O={output.metrics} \
            R={input.fasta} \
        """