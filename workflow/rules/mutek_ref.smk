rule mdup_ref:
        input:
                inp=[config['outdir']+'/align/{sample}_mtmerged_refdup_sorted.bam'.format(sample=sample_id) for sample_id in sample_ids],
                idx=config['genome']+'/non_control_region.chrM.interval_list',
                ref=config['genome']+'/hg38.chrM.fa'
        output:
                out=[config['outdir']+'/variants/{sample}_mtmerged_ref.vcf'.format(sample=sample_id) for sample_id in sample_ids],
                out2=[config['outdir']+'/variants/{sample}_mtmerged_ref.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids]
        threads: 32
        run:
                for i in range(cnt):
                        input1=input.inp[i]
                        outp=output.out[i]
                        shell('gatk Mutect2 -R {input.ref} -L {input.idx} --mitochondria-mode -I {input1} -O {outp}')


