nextflow.enable.dsl=2

process TRIMMOMATIC {
    tag "$sample_id"
    publishDir "${params.outdir}/trimmed", mode: 'copy'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}_P_1.fastq.gz"), path("${sample_id}_P_2.fastq.gz")

    script:
    """
    trimmomatic PE \\
        -threads ${params.threads} \\
        -phred33 \\
        ${reads[0]} ${reads[1]} \\
        ${sample_id}_P_1.fastq.gz ${sample_id}_U_1.fastq.gz \\
        ${sample_id}_P_2.fastq.gz ${sample_id}_U_2.fastq.gz \\
        ILLUMINACLIP:${params.adapters}:2:30:10 \\
        SLIDINGWINDOW:4:15 \\
        MINLEN:36
    """
}

