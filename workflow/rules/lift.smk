rule lift_mtshift:
    output:
        merged="results/variants/{sample}.merged.lift.vcf",
        rejected="results/variants/{sample}.rejected.lift.vcf"
    input:
        vcf="results/variants/{sample}.merged.mtshft.mkdups.vcf",
        chain=config["mt_back_chain"],
        ref=config["mt_ref"]
    threads: config["picard"]["threads"]
    resources: 
        mem_mb=config["picard"]["mem_mb"]
    container: config["picard"]["container"]
    shell:
        """
        java -jar /usr/picard/picard.jar LiftoverVcf\
        I={input.vcf} \
        O={output.merged} \
        CHAIN={input.chain} \
        REJECT={output.rejected} \
        R={input.ref}
        """