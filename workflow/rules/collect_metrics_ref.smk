rule collect_wgs_metrics_ref:
    output:
        metrics="results/dedup/{sample}.merged.mtref.mkdups.wgs.metrics.txt"
    input:
        bam="results/dedup/{sample}.merged.mtref.mkdups.sorted.bam",
        fasta=config["mt_ref"]
    container: config["picard"]["container"]
    log:
        "logs/align/{sample}.wgs.metrics.ref.log"
    threads: config["picard"]["threads"]
    resources:
        mem_mb=config["picard"]["mem_mb"]
    shell:
        """
        java -jar /usr/picard/picard.jar CollectWgsMetrics \
            I={input.bam} \
            O={output.metrics} \
            R={input.fasta} \
        """