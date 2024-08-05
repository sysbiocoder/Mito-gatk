rule bwa_shftmtmerge:
    output:
        out="results/align/{sample}.merged.mtshft.bam",
    input:
        bam1="results/align/{sample}.mito.reverted.bam",
        bam2="results/align/{sample}.mt.shft.bam",
        fasta=config["mt_shft_ref"],
    container:
        config["picard"]["container"]
    log:
        "logs/align/{sample}.mt.shft.merge.log",
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
