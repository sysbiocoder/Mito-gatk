rule bwa_shftmtmerge:
    output:
        out="result/align/{sample}_merged_mtshft.bam"
    input:
        bam1="results/align/{sample}.mito.reverted.bam",
        bam2="results/align/{sample}_mt_shft.bam",
        fasta=config['mt_shft_ref']
    container: config["picard"]["sif"]
    log:
        "logs/{sample}_mt_shft_merge.log"
    shell:
        """
        picard MergeBamAlignment \
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