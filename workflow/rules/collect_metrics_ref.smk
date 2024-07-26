rule collect_wgs_metrics_ref:
	output:
        metrics="result/dedup/{sample}_merged_mtref_markdups_wgs_metrics.txt"
    input:
        bam="results/dedup/{sample}_merged_mtref_markdups.bam",
        fasta=config["mt_ref"]
    container: config["picard"]["sif"]
    log:
        "logs/{sample}.wgs.metrics.ref.log"
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