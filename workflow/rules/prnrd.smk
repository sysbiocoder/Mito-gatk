rule prnrds:
	input:
		[config['outdir']+'/align/{sample}.sorted.bam'.format(sample=sample_id) for sample_id in sample_ids] 
	output:
		[config['outdir']+'/align/{sample}.mito.sorted.bam'.format(sample=sample_id) for sample_id in sample_ids] 
	run:
		for i in range(cnt):
			inp=input[i]
			out=output[i]
			shell("gatk PrintReads -L chrM --read-filter MateOnSameContigOrNoMappedMateReadFilter --read-filter MateUnmappedAndUnmappedReadFilter -I {inp} -O {out}")
