rule bwa_refmt:
	input:
		idx1=config['genome']+'/hg38.chrM.fa',
		sam1=[config['outdir']+'/align/{sample}.mito.reverted_1.fq'.format(sample=sample_id) for sample_id in sample_ids],
		sam2=[config['outdir']+'/align/{sample}.mito.reverted_2.fq'.format(sample=sample_id) for sample_id in sample_ids]
	output:
		out1=[config['outdir']+'/align/{sample}_mt_ref.bam'.format(sample=sample_id) for sample_id in sample_ids]
	params:
		rg=expand("@RG\\tID:{sample}\\tPL:ILLUMINA\\tSM:{sample}\\tLB:{library}",sample=sample_ids)
	threads: 32
	run:
		for i in range(cnt):
			input.samp1=input.sam1[i]
			input.samp2=input.sam2[i]
			output.out=output.out1[i]
			rg=params.rg[i]
			shell('bwa mem -M -t 32  -R \'{rg}\' {input.idx1}  {input.samp1} {input.samp2} |samtools view -@ 40 -Sb - | samtools sort -@ 40 -o {output.out}')
