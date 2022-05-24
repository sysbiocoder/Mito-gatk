from pathlib import Path
rule bwa_mem:
	input:
		idx=config['genome']+'/hg38.fa',
		sam1 =[config['indir']+'/{samplefolder}/'+config['mcid']+'_{sample}_{run}_L004_R1_001.fastq.gz'.format(mcid=mc_id, samplefolder=samplefolder_id, sample=sample_id, run=run_id) for mc_id,samplefolder_id, sample_id, run_id in zip(mcids,samplefolder_ids, sample_ids, run_ids)],
		sam2 =[config['indir']+'/{samplefolder}/'+config['mcid']+'_{sample}_{run}_L004_R2_001.fastq.gz'.format(mcid=mc_id, samplefolder=samplefolder_id, sample=sample_id, run=run_id) for mc_id,samplefolder_id, sample_id, run_id in zip(mcids,samplefolder_ids, sample_ids, run_ids)]
	output:
		out1=[config['outdir']+'/align/{sample}.sorted.bam'.format(sample=sample_id) for sample_id in sample_ids],
		out2=[config['outdir']+'/align/{sample}.sorted.bam.bai'.format(sample=sample_id) for sample_id in sample_ids]

	log:
		expand(config['outdir']+'/align/{sample}.log',sample=sample_ids)
	params:
		rg=expand("@RG\\tID:{sample}\\tPL:ILLUMINA\\tSM:{sample}\\tLB:WES",sample=sample_ids)

	threads: 40
	run:
		for i in range(cnt):
			input.samp1=input.sam1[i]
			input.samp2=input.sam2[i]
			output1=output.out1[i]
			output2=output.out2[i]
			rg=params.rg[i]
			shell('bwa mem -M -t 40 -R \'{rg}\' {input.idx} {input.samp1} {input.samp2} | samtools view -@ 40 -Sb - | samtools sort -@ 40 - -o {output1}' )
			shell('samtools index -@ 40 {output1} {output2} {log}')

