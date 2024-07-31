rule mutect_ref:
    input:
        fasta=config["mt_ref"],
        map="results/dedup/{sample}.merged.mtref.mkdups.sorted.bam"
    output:
        vcf="results/variants/{sample}.merged.mtref.mkdups.vcf",
        stats="results/variants/{sample}.merged.mtref.mkdups.vcf.stats"
    message:
        "Testing Mutect2 with {wildcards.sample}"
    threads: config["gatk"]["threads"]
    resources:
        mem_mb=config["gatk"]["mem_mb"],
    container: config["gatk"]["container"]
    params:
        intervals=config["mt_non_control_region"]
    log:
        "logs/align/{sample}.mutect.ref.log",
    shell: 
        """
        gatk Mutect2 \
        -R {input.fasta} \
        -L {params.intervals} \
        --read-filter MateOnSameContigOrNoMappedMateReadFilter \
        --read-filter MateUnmappedAndUnmappedReadFilter \
        --mitochondria-mode \
        --annotation StrandBiasBySample \
        -I {input.map} -O {output.vcf} 2> {log}
        """
