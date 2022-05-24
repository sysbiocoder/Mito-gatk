print(samplefolder_ids)
rule fastqc:
	input:
		sam1 =[config['indir']+'/{samplefolder}/'+config['mcid']+'_{sample}_{run}_L004_R1_001.fastq.gz'.format( samplefolder=samplefolder_id, sample=sample_id, run=run_id) for samplefolder_id, sample_id, run_id in zip(samplefolder_ids, sample_ids, run_ids)],
		sam2 =[config['indir']+'/{samplefolder}/'+config['mcid']+'_{sample}_{run}_L004_R2_001.fastq.gz'.format( samplefolder=samplefolder_id, sample=sample_id, run=run_id) for samplefolder_id, sample_id, run_id in zip(samplefolder_ids, sample_ids, run_ids)]
	output:
		[config['outdir']+'/qc/'+config['mcid']+'_{sample}_{run}_L004_R1_001_fastqc.html'.format(sample=sample_id, run=run_id) for sample_id, run_id in zip( sample_ids, run_ids)],
		[config['outdir']+'/qc/'+config['mcid']+'_{sample}_{run}_L004_R2_001_fastqc.html'.format(sample=sample_id, run=run_id) for sample_id, run_id in zip( sample_ids, run_ids)]
	params:
		dir=config['outdir']+'/qc'
	threads: 40
	shell:
		"""
		fastqc  -t {threads} {input.sam1} {input.sam2} -o {params.dir}  
		"""
