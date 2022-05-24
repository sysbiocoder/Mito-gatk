rule liftmtshift:
    input:
        inp=[config['outdir']+'/variants/{sample}_mtmerged_shft.vcf'.format(sample=sample_id) for sample_id in sample_ids],
        chn=config['genome']+'/ShiftBack.chain',
        ref=config['genome']+'/hg38.chrM.fa'
    output:
        out1=[config['outdir']+'/variants/{sample}_mtmerged_lift.vcf'.format(sample=sample_id) for sample_id in sample_ids],
        out2=[config['outdir']+'/variants/{sample}_rejected_lift.vcf'.format(sample=sample_id) for sample_id in sample_ids]
    threads: 32
    run:
        for i in range(cnt):
            input1=input.inp[i]
            outp1=output.out1[i]
            outp2=output.out2[i]
            shell('picard LiftoverVcf I={input1} O={outp1} CHAIN={input.chn} REJECT={outp2} R={input.ref}')
