#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.reads     = "./data/*_{1,2}.fastq.gz""
params.adapters  = "./TruSeq3-PE.fa"
params.outdir    = "./results"
params.hisat2idx = "./hisat2_index/genome"
params.threads   = 4

include { TRIMMOMATIC } from './modules/trimming.nf'
include { ALIGN       } from './modules/align.nf'
include { SAM2BAM     } from './modules/samtools.nf'

workflow {
    reads_ch     = Channel.fromFilePairs(params.reads, flat: true)
    trimmed_ch   = TRIMMOMATIC(reads_ch)
    aligned_ch   = ALIGN(trimmed_ch)
    sorted_bam   = SAM2BAM(aligned_ch)
}

