rule dup_ref:
        input:
                [config['outdir']+'/align/{sample}_merged_mtref.bam'.format(sample=sample_id) for sample_id in sample_ids]
        output:
                out=[config['outdir']+'/align/{sample}_mtmerged_refdup.bam'.format(sample=sample_id) for sample_id in sample_ids],
                outs=[config['outdir']+'/align/{sample}_mtmerged_refdup_sorted.bam'.format(sample=sample_id) for sample_id in sample_ids],
                metrics=[config['outdir']+'/align/{sample}_mtmerged_refdup_met.txt'.format(sample=sample_id) for sample_id in sample_ids]
        threads: 40
        run:
                for i in range(cnt):
                        inp=input[i]
                        outp=output.out[i]
                        outs=output.outs[i]
                        metrics=output.metrics[i]
                        shell("picard MarkDuplicates OUTPUT={outp} INPUT={inp} METRICS_FILE={metrics} VALIDATION_STRINGENCY=SILENT CREATE_INDEX=true OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 ASSUME_SORT_ORDER=queryname CLEAR_DT=false ADD_PG_TAG_TO_READS=false")
                        shell('samtools sort -@ {threads} {outp} -o {outs}')
                        shell('samtools index -@ {threads} {outs} ')

