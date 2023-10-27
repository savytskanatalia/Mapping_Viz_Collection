# Generating .bw files from sorted .bam files
# I am using docker image dukegcb/deeptools to run necessary commands

# Simple example with aggregation of coverage depth for binSize of 10 bp
docker run -it -v /mnt/md0/natalia:/data dukegcb/deeptools bamCoverage --binSize 10 -b /data/Sample01.bam -o  /data/Sample01.bw

# Aggregating for non-stranded RNA-seq (other) protocol per strand requires a modification of a command with flag inclusion:
# --filterRNAstrand forward
# --filterRNAstrand reverse

docker run -it -v /mnt/md0/natalia:/data dukegcb/deeptools bamCoverage --binSize 10 --filterRNAstrand forward -b /data/Sample01.bam -o  /data/Sample01_fwd.bw
docker run -it -v /mnt/md0/natalia:/data dukegcb/deeptools bamCoverage --binSize 10 --filterRNAstrand reverse -b /data/Sample01.bam -o  /data/Sample01_rv.bw

# However if the RNA-seq protocol was stranded a more elaborate preparation will be needed - .bam files split into pairs originating from FWD and RV strands separately depending if the protocol was REVERSE (stranded reverse) or DIRECT (stranded yes).
# For those cases use *SplitStrands.sh scripts before running BigWig generation (w/o "--filterRNAstrand", but per individual fwd.bam and rv.bam)


