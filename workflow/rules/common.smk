##############################
# common.smk
#
# Collection of code common to all parts of the workflow
##############################
from snakemake.utils import validate
import pandas as pd

##### load config and sample sheets #####
configfile: "config/config.yaml"


samples = pd.read_csv(config["samples"], sep="\t").set_index("sample", drop=False)
samples.index.names = ["sample_id"]
validate(samples, schema="../schemas/samples.schema.yaml")


reads = pd.read_csv(config["reads"], sep="\t").set_index("sample", drop=False)
reads.index.names = ["sample_id"]
validate(reads, schema="../schemas/reads.schema.yaml")