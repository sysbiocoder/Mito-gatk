rule revert:
        input:
                [config['outdir']+'/align/{sample}.mito.sorted.bam'.format(sample=sample_id) for sample_id in sample_ids] 
        output:
                [config['outdir']+'/align/{sample}.mito.reverted.bam'.format(sample=sample_id) for sample_id in sample_ids] 

        threads: 40
        run:
                for i in range(cnt):
                        inp=input[i]
                        out=output[i]
                        shell("picard RevertSam I={inp} O={out} OUTPUT_BY_READGROUP=false VALIDATION_STRINGENCY=LENIENT ATTRIBUTE_TO_CLEAR=FT ATTRIBUTE_TO_CLEAR=CO SORT_ORDER=queryname RESTORE_ORIGINAL_QUALITIES=false")
                        shell('samtools index -@ 40 {out}')
