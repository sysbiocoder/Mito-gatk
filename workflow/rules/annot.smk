rule hmtnote:
        input:
                [config['outdir']+'/variants/{sample}_mtmerged_filtered_brm.vcf'.format(sample=sample_id) for sample_id in sample_ids]
        output:
                [config['outdir']+'/variants/{sample}_mtmerged_combined_brm_annotated.vcf'.format(sample=sample_id) for sample_id in sample_ids]
        threads: 32
        run:
                for i in range(cnt):
                        inp=input[i]
                        outp=output[i]
                        shell('hmtnote annotate {inp} {outp} --csv --variab --offline')


