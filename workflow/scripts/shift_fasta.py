from Bio import SeqIO

def shift_fasta(input_fasta, output_fasta, break_point):
    # Read the FASTA sequence
    records = list(SeqIO.parse(input_fasta, "fasta"))
    
    if len(records) != 1:
        raise ValueError("This script assumes there is only one sequence in the FASTA file.")
    
    # Get the sequence
    original_seq = records[0].seq
    
    # Split the sequence at the break point
    part1 = original_seq[:break_point]  # 0 to break_point-1
    part2 = original_seq[break_point:]  # break_point to end
    
    # Reorder the sequence
    shifted_seq = part2 + part1
    
    # Create a new SeqRecord for the shifted sequence
    shifted_record = records[0]
    shifted_record.seq = shifted_seq
    
    # Write to a new FASTA file
    with open(output_fasta, "w") as output_handle:
        SeqIO.write(shifted_record, output_handle, "fasta")
    
    print(f"Shifted sequence saved to {output_fasta}")

# Example usage:
input_fasta = "../../resources/mm39/chrMT.fna"  # Replace with your input FASTA file
output_fasta = "../../resources/mm39/chrMT_shifted_8000bp_NEW.fna"  # Output file for the shifted reference
break_point = 8000  # Choose your break point (e.g., 8000 bp)
shift_fasta(input_fasta, output_fasta, break_point)
