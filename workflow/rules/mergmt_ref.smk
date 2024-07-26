rule bwa_refmtmerge:
    output:
        out="results/align/{sample}_merged_mtref.bam"
    input:
        bam1="results/align/{sample}.mito.reverted.bam",
        bam2="results/align/{sample}_mt_ref.bam",
        fasta=config['mt_ref']
    container: config["picard"]["container"]
    log:
        "logs/{sample}_mt_ref_merge.log"
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