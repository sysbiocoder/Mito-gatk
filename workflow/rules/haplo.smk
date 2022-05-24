rule hap_ref:
        input:
                inp1=[config['outdir']+'/align/{sample}_mtmerged_refdup_sorted.bam'.format(sample=sample_id) for sample_id in sample_ids],
                inp2=[config['outdir']+'/align/{sample}_mtmerged_shftdup_sorted.bam'.format(sample=sample_id) for sample_id in sample_ids]
        params:
                dir=[config['outdir']+'/haplo/{sample}'.format(sample=sample_id) for sample_id in sample_ids]
        output:
                con=[config['outdir']+'/haplo/{sample}/contamination/contamination.txt'.format(sample=sample_id) for sample_id in sample_ids],
                con2=[config['outdir']+'/haplo/{sample}/contamination_extended/contamination_extended.txt'.format(sample=sample_id) for sample_id in sample_ids],
                rep=[config['outdir']+'/haplo/{sample}/report/report.html'.format(sample=sample_id) for sample_id in sample_ids]
        threads: 32
        run:
                for i in range(cnt):
                        input1=input.inp1[i]
                        input2=input.inp2[i]
                        parm=params.dir[i]
                        shell("tools/./cloudgene run haplocheck@1.3.3 --files {input1} --format bam --output {parm} ")
                        shell("tools/./cloudgene run haplocheck@1.3.3  --files {input2} --format bam --output {parm} ")

