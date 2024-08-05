rule mutect_shft:
    output:
        vcf="results/variants/{sample}.merged.mtshft.mkdups.vcf",
        stats="results/variants/{sample}.merged.mtshft.mkdups.vcf.stats"
    input:
        fasta=config["mt_shft_ref"],
        map="results/dedup/{sample}.merged.mtshft.mkdups.sorted.bam"
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

