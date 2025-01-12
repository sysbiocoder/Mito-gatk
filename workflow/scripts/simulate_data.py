from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

# File paths
reference_fasta = "../../resources/testing/BALB_cJ_v3_chrMT.fasta"  # File with wild-type sequences
mutated_fasta = "../../resources/testing/BALB_cJ_v3_chrMT_ms.fasta"  # File with mutated sequences
output_file = "../../resources/testing/BALB_cJ_v3_chrMT_ms_heteroplasmic_5.0.fasta"  # File with some mutated MT copies
nuclear_genome_fasta = "../../resources/testing/GCA_921997145-chromosomes.fasta" # Genome reference
final_output_fasta = "../../resources/testing/BALB_cJ_v3_combined_nuclear_mt_synthetic_5.0.fasta" # Final output file


def generate_final_fasta(mutated_mt_fasta, non_mutated_mt_fasta, output_fasta, num_mutated_copies=300, num_non_mutated_copies=5700):
    # Read sequences from the mutated and non-mutated mitochondrial FASTA files
    mutated_mt_seq = next(SeqIO.parse(mutated_mt_fasta, "fasta"))
    non_mutated_mt_seq = next(SeqIO.parse(non_mutated_mt_fasta, "fasta"))
    
    # Create 300 copies of the mutated mitochondrial sequence with unique IDs
    mutated_mt_copies = [
        SeqRecord(mutated_mt_seq.seq, id=f"mutated_mt_copy_{i+1}", description=f"mutated mitochondrial copy {i+1}")
        for i in range(num_mutated_copies)
    ]
    
    # Create 5700 copies of the non-mutated mitochondrial sequence with unique IDs
    non_mutated_mt_copies = [
        SeqRecord(non_mutated_mt_seq.seq, id=f"non_mutated_mt_copy_{i+1}", description=f"non-mutated mitochondrial copy {i+1}")
        for i in range(num_non_mutated_copies)
    ]
    
    # Combine all sequences (mitochondrial copies)
    final_sequences = mutated_mt_copies + non_mutated_mt_copies
    
    # Write to the final FASTA output file
    SeqIO.write(final_sequences, output_fasta, "fasta")
    print(f"Heteroplasmic MT FASTA file written to {output_fasta} with {len(final_sequences)} total sequences.")

# Generate the final FASTA file with the specified file paths and 5% heteroplasmy level
generate_final_fasta(mutated_fasta, reference_fasta, output_file)

# Function to filter out the mitochondrial sequence
def filter_mitochondrial_sequences(input_fasta, output_fasta):
    with open(input_fasta, "r") as infile, open(output_fasta, "w") as outfile:
        for record in SeqIO.parse(infile, "fasta"):
            if "organelle: mitochondrion" not in record.description:
                SeqIO.write(record, outfile, "fasta")

# Step 1: Filter out the mitochondrion from the nuclear genome
filtered_nuclear_fasta = nuclear_genome_fasta.replace(".fasta", "_no_mt.fasta")
filter_mitochondrial_sequences(nuclear_genome_fasta, filtered_nuclear_fasta)

# Step 2: Merge the nuclear genome with synthetic mitochondrial sequences
with open(final_output_fasta, "w") as outfile:
    # Write filtered nuclear genome sequences
    with open(filtered_nuclear_fasta, "r") as infile:
        outfile.write(infile.read())
    
    # Write synthetic mitochondrial sequences
    with open(output_file, "r") as infile:
        outfile.write(infile.read())

print(f"Combined genome with synthetic mitochondria written to {final_output_fasta}")
