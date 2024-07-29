rule mutect_shft:
    input:
        fasta=config["mt_shft_ref"],
        map="results/dedup/{sample}.merged.mtshft.mkdups.sorted.bam"
    output:
        vcf="results/variants/{sample}.merged.mtshft.mkdups.vcf",
    message:
        "Testing Mutect2 with {wildcards.sample} and shifted reference"
    threads: config["gatk"]["threads"]
    resources:
        mem_mb=config["gatk"]["mem_mb"],
    container: config["gatk"]["container"]
    params:
        intervals=config["mt_shft_control_region"]
    log:
        "logs/align/{sample}.mutect.shft.log",
    shell:
        """
        gatk Mutect2 \
        -R {input.fasta} \
        -L {params.intervals} \
        --read-filter MateOnSameContigOrNoMappedMateReadFilter \
        --read-filter MateUnmappedAndUnmappedReadFilter \
        --mitochondria-mode \
        --annotation StrandBiasBySample \
        -I {input.map} -O {output.vcf}
        """

#rule mdup_shf:
#        input:
#                inp=[config['outdir']+'/align/{sample}_mtmerged_shftdup_sorted.bam'.format(sample=sample_id) for sample_id in sample_ids],
#                idx=config['genome']+'/hg38_v0_chrM_control_region_shifted.chrM.interval_list',
#                ref=config['genome']+'/hg38.chrM.shifted8000.fa'
#        output:
#                out=[config['outdir']+'/variants/{sample}_mtmerged_shft.vcf'.format(sample=sample_id) for sample_id in sample_ids],
#                out2=[config['outdir']+'/variants/{sample}_mtmerged_shft.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids]
#                
#        threads: 32
#        run:
#                for i in range(cnt):
#                        input1=input.inp[i]
#                        outp=output.out[i]
#                        shell('gatk Mutect2 -R {input.ref} -L {input.idx} --mitochondria-mode -I {input1} -O {outp}')


