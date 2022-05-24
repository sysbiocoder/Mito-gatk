rule bwa_shfmtmerge:
	input:
		sam1=[config['outdir']+'/align/{sample}.mito.reverted.bam'.format(sample=sample_id) for sample_id in sample_ids],
		sam2=[config['outdir']+'/align/{sample}_mt_shift.bam'.format(sample=sample_id) for sample_id in sample_ids],
		fasta=config['genome']+'/hg38.chrM.shifted8000.fa'
	output:
		out=[config['outdir']+'/align/{sample}_merged_mtshft.bam'.format(sample=sample_id) for sample_id in sample_ids]
	threads: 32
	run:
		for i in range(cnt):
			input.samp1=input.sam1[i]
			input.samp2=input.sam2[i]
			output.out1=output.out[i]
			shell('picard MergeBamAlignment ALIGNED={input.samp2} UNMAPPED={input.samp1} O={output.out1} R={input.fasta} CREATE_INDEX=true MAX_GAPS=-1 SORT_ORDER=queryname INCLUDE_SECONDARY_ALIGNMENTS=false PAIRED_RUN=false')

