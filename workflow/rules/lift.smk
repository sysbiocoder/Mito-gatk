rule liftmtshift:
    output:
        merged="results/variants/{sample}_mtmerged_lift.vcf",
        rejected="results/variants/{sample}_rejected_lift.vcf"
    input:
        vcf="results/variants/{sample}_merged_mtshft_markdups.vcf"
        chain=config["mt_back_chain"],
        ref=config["mt_ref"]
    threads: config["picard"]["threads"]
    resources: config["picard"]["mem_mb"]
    container: config["picard"]["container"]
    params:
    shell:
    """
    picard LiftoverVcf \ 
    I={input.vcf} \ 
    O={output.merged} \
    CHAIN={input.chain} \ 
    REJECT={output.rejected} \ 
    R={input.ref}'
    """

#rule liftmtshift:
#    input:
#        inp=[config['outdir']+'/variants/{sample}_mtmerged_shft.vcf'.format(sample=sample_id) for sample_id in sample_ids],
#        chn=config['genome']+'/ShiftBack.chain',
#        ref=config['genome']+'/hg38.chrM.fa'
#    output:
#        out1=[config['outdir']+'/variants/{sample}_mtmerged_lift.vcf'.format(sample=sample_id) for sample_id in sample_ids],
#        out2=[config['outdir']+'/variants/{sample}_rejected_lift.vcf'.format(sample=sample_id) for sample_id in sample_ids]
#    threads: 32
#    run:
#        for i in range(cnt):
#            input1=input.inp[i]
#            outp1=output.out1[i]
#            outp2=output.out2[i]
#            shell('picard LiftoverVcf I={input1} O={outp1} CHAIN={input.chn} REJECT={outp2} R={input.ref}')
