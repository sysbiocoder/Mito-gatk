rule filt:
    input:
        inp=[config['outdir']+'/variants/{sample}_mtmerged_combined.vcf'.format(sample=sample_id) for sample_id in sample_ids],
        ref=config['genome']+'/hg38.chrM.fa',
        cont=[config['outdir']+'/haplo/{sample}/contamination_extended/contamination_extended.txt'.format(sample=sample_id) for sample_id in sample_ids],
        stats=[config['outdir']+'/variants/{sample}_mtmerged_combined.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids]
    output:
        out=[config['outdir']+'/variants/{sample}_mtmerged_filtered.vcf'.format(sample=sample_id) for sample_id in sample_ids]

    run:
        for i in range(cnt):
            inp=input.inp[i]
            ref=input.ref
            out=output.out[i]
            con=input.cont[i]
            stt=input.stats[i]
            a=shell('python scripts/get_cm.py -c {con}')
            shell('gatk FilterMutectCalls -V {inp} -R {ref} --stats {stt}   --max-alt-allele-count 4 --mitochondria-mode   -O {out}') # Autosomal coverage
