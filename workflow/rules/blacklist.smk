rule blfilt:
    input:
        inp=[config['outdir']+'/variants/{sample}_mtmerged_filtered.vcf'.format(sample=sample_id) for sample_id in sample_ids],
        ref=config['genome']+'/hg38.chrM.fa',
        stats=[config['outdir']+'/variants/{sample}_mtmerged_combined.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids]
    output:
        out=[config['outdir']+'/variants/{sample}_mtmerged_filtered_brm.vcf'.format(sample=sample_id) for sample_id in sample_ids]
    run:
        for i in range(cnt):
            inp=input.inp[i]
            ref=input.ref
            out=output.out[i]
            shell('gatk VariantFiltration -V {inp} -R {ref} -O {out}')