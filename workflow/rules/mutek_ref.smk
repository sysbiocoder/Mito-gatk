rule mutect_ref:
    input:
        fasta=config["mt_ref"],
        map="results/dedup/{sample}_merged_mtref_mkdups.bam",
        intervals=config["mt_non_control_region"]
    output:
        vcf="results/variants/{sample}_merged_mtref_mkdups.vcf",
    message:
        "Testing Mutect2 with {wildcards.sample}"
    threads: config["gatk"]["threads"]
    resources:
        mem_mb=config["gatk"]["mem_mb"],
    params:
        extra="--mitochondria"
    log:
        "logs/{sample}.mutect.ref.log",
    wrapper:
        "v3.13.8/bio/gatk/mutect"

#rule mdup_ref:
#        input:
#                inp=[config['outdir']+'/align/{sample}_mtmerged_refdup_sorted.bam'.format(sample=sample_id) for sample_id in sample_ids],
#                idx=config['genome']+'/non_control_region.chrM.interval_list',
#                ref=config['genome']+'/hg38.chrM.fa'
#        output:
#                out=[config['outdir']+'/variants/{sample}_mtmerged_ref.vcf'.format(sample=sample_id) for sample_id in sample_ids],
#                out2=[config['outdir']+'/variants/{sample}_mtmerged_ref.vcf.stats'.format(sample=sample_id) for sample_id in sample_ids]
#        threads: 32
#        run:
#                for i in range(cnt):
#                        input1=input.inp[i]
#                        outp=output.out[i]
#                        shell('gatk Mutect2 -R {input.ref} -L {input.idx} --mitochondria-mode -I {input1} -O {outp}')

