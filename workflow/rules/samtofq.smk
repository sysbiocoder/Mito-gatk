rule revertfq:
	input:
		[config['outdir']+'/align/{sample}.mito.reverted.bam'.format(sample=sample_id) for sample_id in sample_ids] 
	output:
		out1=[config['outdir']+'/align/{sample}.mito.reverted_1.fq'.format(sample=sample_id) for sample_id in sample_ids],
		out2=[config['outdir']+'/align/{sample}.mito.reverted_2.fq'.format(sample=sample_id) for sample_id in sample_ids]
	threads: 32
	run:
		for i in range(cnt):
			inp=input[i]
			out1=output.out1[i]
			out2=output.out2[i]
			shell('picard SamToFastq I={inp} F={out1} F2={out2}')
