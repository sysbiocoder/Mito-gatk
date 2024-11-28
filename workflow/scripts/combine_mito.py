from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

def concatenate_mito_sequences(input_fasta, output_fasta, position_map_file, mito_prefix="mutated_mt_copy", non_mutated_prefix="non_mutated_mt_copy"):
    """
    Concatenate all mitochondrial sequences into a single entry and generate a mapping of each copy's start-end positions.
    Include all nuclear chromosome records in the output FASTA file.
    
    Parameters:
        input_fasta (str): Path to the input FASTA file.
        output_fasta (str): Path to the output FASTA file with combined mitochondrial sequences.
        position_map_file (str): Path to the output position map file.
        mito_prefix (str): Prefix for identifying mutated mitochondrial sequences in headers.
        non_mutated_prefix (str): Prefix for identifying non-mutated mitochondrial sequences in headers.
    """

    # Initialize variables
    combined_mito_sequence = ""
    position_map = []
    current_position = 0
    nuclear_sequences = []

    # Read and process the input fasta
    with open(input_fasta, "r") as input_handle:
        for record in SeqIO.parse(input_handle, "fasta"):
            # Check if the record is a mitochondrial copy
            if mito_prefix in record.id or non_mutated_prefix in record.id:
                # Append sequence to the combined mito sequence
                combined_mito_sequence += str(record.seq)
                
                # Record start and end positions for each mitochondrial copy
                start_position = current_position
                end_position = current_position + len(record.seq)
                position_map.append((record.id, start_position, end_position))
                
                # Update current position for the next sequence
                current_position = end_position
            else:
                # Collect nuclear sequences
                nuclear_sequences.append(record)

    # Create a SeqRecord for the combined mitochondrial sequence
    combined_mito_seq_record = SeqRecord(
        seq=Seq(combined_mito_sequence),
        id="combined_mito",
        description="Concatenated mitochondrial copies"
    )

    # Write all nuclear sequences and the combined mitochondrial sequence to output fasta
    with open(output_fasta, "w") as output_handle:
        SeqIO.write(nuclear_sequences, output_handle, "fasta")
        SeqIO.write(combined_mito_seq_record, output_handle, "fasta")

    # Write the position map to a text file
    with open(position_map_file, "w") as map_file:
        for record_id, start, end in position_map:
            map_file.write(f"{record_id}\t{start}\t{end}\n")

# Usage
input_fasta = "../../resources/testing/BALB_cJ_v3_combined_nuclear_mt_synthetic_1.0.fasta"
output_fasta = "../../resources/testing/BALB_cJ_v3_combined_nuclear_mt_synthetic_1.0_COMBINED.fasta"
pos_map = "../../resources/testing/BALB_cJ_v3_combined_nuclear_mt_synthetic_1.0_COMBINED_POS_MAP.txt"

concatenate_mito_sequences(input_fasta, output_fasta, pos_map)
