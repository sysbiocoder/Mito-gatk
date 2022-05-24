rule mergemtshiftref:
    input:
        inp1=[config['outdir']+'/variants/{sample}_mtmerged_lift.vcf'.format(sample=sample_id) for sample_id in sample_ids],
        inp2=[config['outdir']+'/variants/{sample}_mtmerged_ref.vcf'.format(sample=sample_id) for sample_id in sample_ids],
        inps1=[config['outdir']+'/variants/{sample}_mtmerged_shft.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids],
        inps2=[config['outdir']+'/variants/{sample}_mtmerged_ref.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids]

    output:
        out=[config['outdir']+'/variants/{sample}_mtmerged_combined.vcf'.format(sample=sample_id) for sample_id in sample_ids],
        stats=[config['outdir']+'/variants/{sample}_mtmerged_combined.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids]
    threads: 32
    run:
        for i in range(cnt):
            input1=input.inp1[i]
            input2=input.inp2[i]
            st1=input.inps1[i]
            st2=input.inps2[i]
            outp=output.out[i]
            stat=output.stats[i]
            shell('picard MergeVcfs I={input1} I={input2} O={outp}')
            shell('python scripts/combstats.py -r {st1} -s {st2} -o {stat} ' )


