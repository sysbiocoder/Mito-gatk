rule bwa_refmtmerge:
    output:
        out="results/align/{sample}.merged.mtref.bam",
    input:
        bam1="results/align/{sample}.mito.reverted.bam",
        bam2="results/align/{sample}.mt.ref.bam",
        fasta=config["mt_ref"],
    container:
        config["picard"]["container"]
    threads: config["picard"]["threads"]
    resources:
        mem_mb=config["picard"]["mem_mb"],
    log:
        "logs/align/{sample}.mt.ref.merge.log",
    shell:
        """
        java -jar /usr/picard/picard.jar MergeBamAlignment \
            ALIGNED={input.bam2} \
            UNMAPPED={input.bam1} \
            O={output.out} \
            R={input.fasta} \
            CREATE_INDEX=true \
            MAX_GAPS=-1 \
            SORT_ORDER=queryname \
            INCLUDE_SECONDARY_ALIGNMENTS=false \
            PAIRED_RUN=false
        """
