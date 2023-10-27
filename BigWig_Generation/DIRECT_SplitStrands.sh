set -ue
# Script for splitting mapping info by strands for paired-end stranded (DIRECT) RNA-seq
# example
# sh split.sh input.ba
# Get the bam file from the command line
DATA=$1

# This script is for Stranded (Stranded - yes, direct, FR, R1R2) experiments

# Forward strand. R1+,R2-
# 1. alignments of the first in pair if they map to the forward strand; -f 64 - first in pair, -F 16 exclude reverse strand
samtools view -b -f 64 -F 16 $DATA > "$DATA"_fwd1.bam
# 2. alignments of the second in pair if they map to the reverse strand; 128 - second in pair; 16 - reverse' 128+16=144
samtools view -b -f 144 $DATA > "$DATA"_fwd2.bam

# Combine alignments that originate on the forward strand.
samtools merge -f "$DATA"_fwd.bam "$DATA"_fwd1.bam "$DATA"_fwd2.bam
samtools index "$DATA"_fwd.bam


# Reverse strand. R1-,R2+

# 1. alignments of the first in pair if they map to the reverse  strand; 64 - first in pair, 16-reverse strand, 64+16=80
samtools view -b -f 80 $DATA > "$DATA"_rev1.bam

# 1. alignments of the second in pair if they map to the forward strand; where (-f 128) is flag for "include 2nd in pair" and (-F 16) for "exclude reverse stranded"
samtools view -b -f 128 -F 16 $DATA > "$DATA"_rev2.bam


# Combine alignments that originate on the reverse strand.
#
samtools merge -f "$DATA"_rev.bam "$DATA"_rev1.bam "$DATA"_rev2.bam
samtools index "$DATA"_rev.bam
