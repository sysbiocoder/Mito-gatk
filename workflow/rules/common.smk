configfile: "../config/config.yaml"
import os
import glob
samplefolder_ids,sample_ids, run_ids = glob_wildcards(config['indir']+"/{samplefolder}/"+config['mcid']+"_{sample}_{run}_L004_R1_001.fastq.gz")
print(sample_ids)
print(samplefolder_ids)
cnt=config['samplescount']
mcids=config['mcid']
print(mcids)