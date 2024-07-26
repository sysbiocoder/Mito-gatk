rule collect_wgs_metrics_shft:
	output:
        metrics="result/dedup/{sample}_merged_mtshft_markdups_wgs_metrics.txt"
    input:
        bam="results/dedup/{sample}_merged_mtshft_markdups.bam",
        fasta=config["mt_shft_ref"]
    container: config["picard"]["sif"]
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